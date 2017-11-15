require 'rails_helper'

RSpec.describe WebhookService do

  it "associates the event to an existing user" do
    user = User.create(login: 'asdas', uid: 123, profile_image: 'http://test.com/name', gh_webhook_token: '12345abcde')

    params = {
      gh_webhook_token: '12345abcde',
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
      organization: {
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
          expect do
            WebhookService.new.call(params)
          end.to change {user.organizations.count}.by(1)
        end.to change{user.repositories.count}.by(1)
      end.to change{user.pull_requests.count}.by(1)
    end.to change{Comment.count}.by(1)
  end

  it "raises WebhookService::UserNotFound error if webhook is sent to invalid user" do
    User.create(login: 'asdas', uid: 123, profile_image: 'http://test.com/name', gh_webhook_token: '12345abcdeasdasd')
    params = {
      gh_webhook_token: '12345abcdedsa',
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
    expect{WebhookService.new.call(params)}.to raise_error(WebhookService::UserNotFound)
  end
end
