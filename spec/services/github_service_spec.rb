require 'rails_helper'

RSpec.describe GithubService do

  let(:token) { '123abc' }
  let(:auth)  { OmniAuth.config.mock_auth[:github] }
  let(:organizations) { [{ login: 'organization_name', avatar_url: 'https://test_org.com/name', description: 'asdasd'}] }
  let(:org_repos) { [ OpenStruct.new(full_name: 'repo_1') ] }
  let(:pull_request_user) { OpenStruct.new(avatar_url: 'avatar_url') }
  let(:pull_requests) { [ OpenStruct.new(id: '123', number: 123, state: 'open', title: 'title', body: 'body', author: 'test_user', user: pull_request_user) ] }
  let(:user) { OpenStruct.new(uid: 123, login: 'testuser', profile_image: 'https://test_user.com/name')}
  
  specify 'fetch and save user data from GitHub API' do
    ENV['GITHUB_ACCESS_TOKEN'] = token
      
    service = described_class.new(user, token)
    expect(service).to receive(:call).and_return(organizations)
    expect(service).to receive(:call).and_return(org_repos)
    expect(service).to receive(:call).and_return(pull_requests)
    debugger
    expect { service.call }.to change{PullRequest.count}.by(1)
    
  end
end
