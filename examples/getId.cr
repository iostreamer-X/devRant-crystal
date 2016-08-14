require "../src/*"

DevRant.getIdByUsernameAsync "coookie" do |user_id|
  puts user_id
end

puts DevRant.getIdByUsername "coookie"


DevRant.getRantsAsync({} of String => String) do |rants|
  puts rants[0]
end

puts DevRant.getRants()[0]


DevRant.getRantFromIdAsync "141356" do |rant|
  puts rant["text"]
end

puts DevRant.getRantFromId "141356"


DevRant.searchAsync "iostreamer" do |results|
  puts results[0]
end

puts DevRant.search("iostreamer")[0]


DevRant.getProfileAsync "coookie" do |profile|
  puts profile["username"]
end

puts DevRant.getProfile("coookie")["username"]

#To get this example working, we need to sleep
sleep
