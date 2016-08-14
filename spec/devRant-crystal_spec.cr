require "./spec_helper"
require "json"

describe DevRant do

  it "getIdByUsername" do
    DevRant.getIdByUsername("coookie").should eq "82833"
  end
end
