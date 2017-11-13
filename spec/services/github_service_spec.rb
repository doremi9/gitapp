require 'rails_helper'

RSpec.describe GithubService do

  let(:token) { '123abc' }

  specify '' do

    ENV['GITHUB_ACCESS_TOKEN'] = token

    service = described_class.new(user, token)
    puts service
    # expect ...
    #
    expect { service.call }.to change{Organization.count}.by(1)
  end
end
