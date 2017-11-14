require 'rails_helper'

RSpec.describe GithubService do

  let(:token) { '123abc' }
  let(:auth)  { OmniAuth.config.mock_auth[:github] }
  let(:organizations) { [{ login: 'organization_name', avatar_url: 'https://test_org.com/name', description: 'asdasd'}] }
  let(:org_repos) { [ OpenStruct.new(full_name: 'repo_1') ] }
  let(:pull_request_user) { OpenStruct.new(avatar_url: 'avatar_url') }
  let(:pull_requests) { [ OpenStruct.new(id: '123', number: 123, state: 'open', title: 'title', body: 'body', author: 'test_user', user: pull_request_user) ] }
  let(:user) { User.create(login: 'testuser', uid: 123, profile_image: 'https://test_org.com/name') }
  
  specify 'fetch and save user data from GitHub API' do
    ENV['GITHUB_ACCESS_TOKEN'] = token
      
    fake_octokit_client = double('fake octokit client')
    expect(fake_octokit_client).to receive(:organizations).and_return(organizations)
    expect(fake_octokit_client).to receive(:org_repos).and_return(org_repos)
    expect(fake_octokit_client).to receive(:pull_requests).with('repo_1').and_return(pull_requests)
    expect(Octokit::Client).to receive(:new).with(access_token: token)
                              .and_return(fake_octokit_client)
    service = described_class.new(user, token)
    expect do
      expect do
        expect do
          service.call
        end.to change { user.organization.count }.by(1)
      end.to change { user.repositories.count }.by(1)
    end.to change{ user.count }.by(1)
  end
end
