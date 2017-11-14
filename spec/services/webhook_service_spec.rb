require 'rails_helper'

Rspec.describe WebhookService do
  
  params = {
    gh_webhook_token: token
    github: {
      action: "opened"
    },
    pull_request: {
      id: 123,
      number: 1,
      state: "open",
      title: "test title",
      body: "test body"
    },
    organizations: {
      login: "testlogin",
      avatar_url: "http://test.com/name",
      description: "description"
    },
    repository: {
      full_name: "testname"
    },
    sender: {
      login: "testsenderlogin",
      author_avatar_url: "http://test.com/username"
    }
  }

  expect do
    expect do
      expect do
        WebhookService.new.call(params)
      end.to change {user.organizations.count}.by(1)
    end.to change(user.repositories.count}.by(1)
  end.to change(PullRequest.count}.by(1)
  #plus sprawdzić, czy dodawany jest komentarz dla konkretnego pull requestu
end
