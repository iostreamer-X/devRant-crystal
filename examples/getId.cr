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
#To get this example working, we need to sleep
sleep
