module Features
  def payload 
    {
      github: {
        "action": "opened"
      },
      pull_request: {  
        "id": 1234567,
        "number": 1,
        "state": "open",
        "title": "test title",
        "body": "test body"
      },
      "repository": {
        "full_name": "TesOrgJedrek/testrepojedrek"
      },
      "organization": {
        "login": "TesOrgJedrek",
        "avatar_url": "https://avatars0.githubusercontent.com/u/33223623?v=4",
        "description": "My test organization"
      },
      "sender": {
        "login": "testuser",
        "avatar_url": "https://avatars3.githubusercontent.com/"
      }
    }
  end
end