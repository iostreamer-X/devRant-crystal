require "./spec_helper"
require "json"

describe DevRant do
  # TODO: Write tests

  it "getIdByUsernameAsync" do
    DevRant.getIdByUsernameAsync "coookie",->(user_id : String){
      puts user_id
      user_id.should eq "82833"
    }
  end

  it "getIdByUsername" do
    DevRant.getIdByUsername("coookie").should eq "82833"
  end
end
