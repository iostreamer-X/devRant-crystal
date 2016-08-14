require "../src/*"

DevRant.getIdByUsernameAsync "coookie",->(user_id : String){
  puts user_id
}
puts "Now this is async"

#To get this example working, we need to sleep
sleep
