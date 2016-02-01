OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
  "provider"=>"github",
  "uid"=>"11673",
  "info"=> {
    "nickname"=>"rossta",
    "email"=>nil,
    "name"=>"Ross Kaffenberger",
    "image"=>"https://avatars.githubusercontent.com/u/11673?v=3",
    "urls"=>{
      "GitHub"=>"https://github.com/rossta",
      "Blog"=>"https://rossta.net"
    }
  },
  "credentials"=> {
    "token"=>"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    "expires"=>false
  },
  "extra"=>{
    "raw_info"=>{
      "login"=>"rossta",
      "id"=>11673,
      "avatar_url"=>"https://avatars.githubusercontent.com/u/11673?v=3",
      "gravatar_id"=>"",
      "url"=>"https://api.github.com/users/rossta",
      "html_url"=>"https://github.com/rossta",
      "name"=>"Ross Kaffenberger",
      "company"=>"http://devpost.com",
      "blog"=>"https://rossta.net",
      "location"=>"New York City",
      "email"=>"ross@example.com",
      "hireable"=>nil, "bio"=>nil,
      "public_repos"=>88,
      "public_gists"=>43,
      "followers"=>35,
      "following"=>23,
      "created_at"=>"2008-05-27T18:27:16Z",
      "updated_at"=>"2016-01-04T15:30:22Z"
    },
    "all_emails"=>[]
  }
})

