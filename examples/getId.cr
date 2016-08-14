require "../src/*"

DevRant.getIdByUsernameAsync "coookie",->(user_id : String){
  puts user_id
}
