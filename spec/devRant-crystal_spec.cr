require "./spec_helper"
require "json"

describe DevRant do

  it "getIdByUsernameAsync" do
    id = nil
    DevRant.getIdByUsernameAsync "coookie" do |user_id|
      puts user_id
      id = user_id
    end
    sleep 2.seconds
    id.should eq "82833"
  end

  it "getIdByUsername" do
    DevRant.getIdByUsername("coookie").should eq "82833"
  end
end
