require "./devRant-crystal/*"
require "cossack"
require "json"

module DevRant
  extend self

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

  def getIdByUsernameAsync(username : String, proc : Proc(String, _))
    spawn do
      params = {"username"=>username}
      response = COSSACK.get("/get-user-id", params)
      proc.call JSON.parse(response.body)["user_id"].to_s
    end
  end
end
