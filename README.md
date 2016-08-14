# devRant-crystal

A crystal wrapper for devRant API

![](https://travis-ci.org/iostreamer-X/devRant-crystal.svg?branch=master)

Heavily inspired(and in a way ported) from [danillouz/devrant](https://github.com/danillouz/devrant)

![I pretty much copied everything from danillouz/devrant](https://raw.githubusercontent.com/danillouz/devrant/master/img/devrant.png)

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  devRant-crystal:
    github: iostreamer-X/devRant-crystal
```


## Usage
```crystal
require "devRant-crystal"
DevRant.method
```
Each method also has an async verion, which has 'Async' appended to the method name.
```crystal
DevRant.methodAsync do |arg|
  puts arg
end
```


## Methods
After requiring the module, the following methods can be
used:

| METHOD | ARGUMENTS | RETURNS | DESCRIPTION |
| --- | --- | --- | --- |
| getIdFromUsername | Yes | `String` | Retrieve a user's id. |
| getRantFromId | Yes | `Full Rant Object` | Retrieve a single rant from devRant. Use this method to retrieve a rant with its full text and comments. The retrieved rant is a [Full Rant Object](#rant-object-full). |
| getRants | Optional | `Array[Simple Rant Objects]` | Retrieve rants from devRant. The retrieved rants are [Simple Rant Objects](#rant-object-simple). |
| search | Yes | `Array[Simple Rant Objects]` | Retrieve rants from devRant that match a specific search term. The retrieved rants are [Simple Rant Objects](#rant-object-simple). |
| getProfile | Yes | `Profile` | Retrieve the profile of a devRant user by username. The retrieved profile is a [Profile Object](#profile-object). |


## Rant Object Simple
```json
{
  "id": 43511,
  "text": "when people think you know everything...",
  "num_upvotes": 38,
  "num_downvotes": 1,
  "score": 37,
  "created_time": 1464610498,
  "attached_image": {
    "url": "https://d1fvlyhrbsf219.cloudfront.net/devrant/rant/r_43511_uQDW4.jpg",
    "width": 600,
    "height": 300
  },
  "num_comments": 5,
  "tags": [ ],
  "vote_state": 0,
  "user_id": 15601,
  "user_username": "Mung00se",
  "user_score": 272
}
```

## Rant Object Full
```json
{
  "rant": {
    "id": 43511,
    "text": "when people think you know everything...",
    "num_upvotes": 39,
    "num_downvotes": 1,
    "score": 38,
    "created_time": 1464610498,
    "attached_image": {
      "url": "https://d1fvlyhrbsf219.cloudfront.net/devrant/rant/r_43511_uQDW4.jpg",
      "width": 600,
      "height": 300
    },
    "num_comments": 5,
    "tags": [ ],
    "vote_state": 0,
    "user_id": 15601,
    "user_username": "Mung00se",
    "user_score": 273
  },
  "comments": [
    {
      "id": 43529,
      "rant_id": 43511,
      "body": "But at some point we all do it.",
      "num_upvotes": 2,
      "num_downvotes": 0,
      "score": 2,
      "created_time": 1464611516,
      "vote_state": 0,
      "user_id": 505,
      "user_username": "Jumpshot44",
      "user_score": 2233
    }
  ],
  "success": true
}
```

## Profile Object
```json
{
  "username":"coookie",
  "score":553,
  "about":"Heeeyooo! I am a dev and tho I don't have anything to rant about,  I can be funny sometimes!",
  "location":"New delhi",
  "created_time":1466694150,
  "skills":"Node.js Android",
  "github":"iostreamer-X",
  "content": {
    "content": {
      "rants": [
        {
          "id": 38898,
          "text": "",
          "num_upvotes": 35,
          "num_downvotes": 0,
          "score": 35,
          "created_time": 1464211080,
          "attached_image": {
            "url": "https://d1fvlyhrbsf219.cloudfront.net/devrant/rant/r_38898_Z93E9.gif",
            "width": 380,
            "height": 230
          },
          "num_comments": 2,
          "tags": [
            "teams",
            "integration-testing",
            "dependencies"
          ],
          "vote_state": 0,
          "user_id": 27942,
          "user_username": "danillouz",
          "user_score": 207
        }
      ],
      "upvoted": [
        {
          "id": 42586,
          "text": "My office desk",
          "num_upvotes": 65,
          "num_downvotes": 0,
          "score": 65,
          "created_time": 1464530939,
          "attached_image": {
            "url": "https://d1fvlyhrbsf219.cloudfront.net/devrant/rant/r_42586_9jWtu.jpg",
            "width": 800,
            "height": 600
          },
          "num_comments": 18,
          "tags": [
            "mydesk"
          ],
          "vote_state": 0,
          "user_id": 13541,
          "user_username": "dvlpr",
          "user_score": 104
        }
      ],
      "comments": [
        {
          "id": 41422,
          "rant_id": 41065,
          "body": "@xroad Hodor",
          "num_upvotes": 3,
          "num_downvotes": 0,
          "score": 3,
          "created_time": 1464425475,
          "vote_state": 0,
          "user_id": 27942,
          "user_username": "danillouz",
          "user_score": 207
        }
      ]
    },
    "counts": {
      "rants": 5,
      "upvoted": 37,
      "comments": 16
    }
  }
}
```


## Examples

You can see all these functions in action [here](https://github.com/iostreamer-X/devRant-crystal/blob/master/examples/basic.cr)


#### Fetch rant with id `141356` in async manner

```crystal
DevRant.getRantFromIdAsync "141356" do |rant|
  puts rant["text"]
end
```

#### Fetch `10` rants of type `top` and skip the first `10`
```crystal
DevRant.getRants({
	"sort" => 'top',
	"limit" => "10",
	"skip" => "10"
  })
```

#### Fetch `50` rants of type `recent` and skip `0` by using default and async behavior
```crystal
DevRant.getRantsAsync({} of String => String) do |rants|
  puts rants[0]
end
}
```

#### Fetch all rants that match the search term `javascript`
```crystal
puts DevRant.search("javascript")[0]
```

#### Fetch the profile of the devRant user with username `dfox` in async manner
```crystal
DevRant.getProfileAsync "dfox" do |profile|
  puts profile["username"]
end
```

## Contributing

1. Fork it ( https://github.com/iostreamer-X/devRant-crystal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[iostreamer-X]](https://github.com/iostreamer-X) - creator, maintainer
