require "./devRant-crystal/*"
require "cossack"
require "json"

module DevRant
  extend self

  macro makeAsync(function, name, type)
    def {{name.id}}(arg : {{type[0]}}, &callback : {{type[1]}} -> )
      spawn do
        callback.call {{function.id}}(arg)
      end
    end
  end

  class AppIdMiddleware < Cossack::Middleware
    def call(request)
      request.uri = URI.parse "#{request.uri}&app=3"
      app.call(request).tap do |response|
        result = JSON.parse response.body
        if (result["success"].to_s == "false")
          raise "#{request.uri} failed"
        end
        if (result["error"]?)
          raise "#{request.uri} failed"
        end
      end
    end
  end

  API = "https://www.devrant.io/api"
  COSSACK = Cossack::Client.new(API) do |client|
    client.use AppIdMiddleware
  end

  def getIdByUsername(username : String)
    params = {"username"=>username}
    response = COSSACK.get("/get-user-id", params)
    return JSON.parse(response.body)["user_id"].to_s
  end
  makeAsync :getIdByUsername, :getIdByUsernameAsync, {String, String}

  def getRants(params = {"sort"=>"recent", "limit"=>"50", "skip"=>"0"})
    if (params.size == 0)
      params = {"sort"=>"recent", "limit"=>"50", "skip"=>"0"}
    end
    response = COSSACK.get("/devrant/rants", params)
    return JSON.parse(response.body).["rants"]
  end
  makeAsync :getRants, :getRantsAsync, {Hash(String, String), JSON::Any}

  def getRantFromId(id : String)
    response = COSSACK.get("/devrant/rants/#{id}?")
    return JSON.parse(response.body).["rant"]
  end
  makeAsync :getRantFromId, :getRantFromIdAsync, {String, JSON::Any}

  def search(term : String)
    params = {"term" => term}
    response = COSSACK.get("/devrant/search", params)
    return JSON.parse(response.body).["results"]
  end
  makeAsync :search, :searchAsync, {String, JSON::Any}

  def getProfile(username : String)
    id = getIdByUsername username
    response = COSSACK.get("/users/#{id}?")
    return JSON.parse(response.body).["profile"]
  end
  makeAsync :getProfile, :getProfileAsync, {String, JSON::Any}

end
