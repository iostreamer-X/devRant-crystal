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
    return JSON.parse(response.body)["user_id"]
  end
end
