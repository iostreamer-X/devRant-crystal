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

  it "getRantsAsync" do
    channel = Channel(String).new
    DevRant.getRantsAsync({} of String => String) do |rants|
      channel.send rants[0]["id"].to_s
    end
    channel.receive.should contain("141")
  end

  it "getRants" do
    DevRant.getRants()[0]["id"].to_s.should contain("141")
  end

  it "getRantFromIdAsync" do
    channel = Channel(String).new
    DevRant.getRantFromIdAsync "141356" do |rant|
      channel.send rant["id"].to_s
    end
    channel.receive.should eq "141356"
  end

  it "getRantFromId" do
    DevRant.getRantFromId("141356")["id"].to_s.should eq "141356"
  end

  it "searchAsync" do
    channel = Channel(String).new
    DevRant.searchAsync "iostreamer" do |results|
      channel.send results[0]["id"].to_s
    end
    channel.receive.should eq "111352"
  end

  it "search" do
    DevRant.search("iostreamer")[0]["id"].to_s.should eq "111352"
  end

  it "getProfileAsync" do
    channel = Channel(String).new
    DevRant.getProfileAsync "coookie" do |profile|
      channel.send profile["username"].to_s
    end
    channel.receive.should eq "coookie"
  end

  it "getProfile" do
    DevRant.getProfile("coookie")["username"].to_s.should eq "coookie"
  end


end
