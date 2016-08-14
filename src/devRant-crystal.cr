require "./devRant-crystal/*"
require "cossack"
require "json"

module DevRant
  extend self

  macro makeAsync(function, name)
    def {{name.id}}(username : String, &callback : String -> )
      spawn do
        callback.call {{function.id}}(username)
      end
    end
  end

  class AppIdMiddleware < Cossack::Middleware
    def call(request)
      request.uri = URI.parse "#{request.uri}&app=3"
      app.call(request)
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
  makeAsync :getIdByUsername, :getIdByUsernameAsync
end
