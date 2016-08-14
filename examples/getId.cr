require "../src/*"

DevRant.getIdByUsernameAsync "coookie" do |user_id|
  puts user_id
end
puts "Now this is async"

#To get this example working, we need to sleep
sleep
