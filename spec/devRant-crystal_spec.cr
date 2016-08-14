require "./spec_helper"
require "json"

describe DevRant do

  it "getIdByUsernameAsync" do
    channel = Channel(String).new
    DevRant.getIdByUsernameAsync "coookie" do |user_id|
      channel.send user_id
    end
    channel.receive.should eq "82833"
  end

  it "getIdByUsername" do
    DevRant.getIdByUsername("coookie").should eq "82833"
  end
end
