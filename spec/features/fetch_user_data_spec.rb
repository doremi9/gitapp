require 'rails_helper'

RSpec.feature "Github Service", type: :feature do
  let(:token) { '123abc' }
  let(:organizations) { [ { login: 'organization_name', avatar_url: 'https://test_org.com/name', description: 'asdasd'}] }
  let(:org_repos) { [ OpenStruct.new(full_name: 'repo_1') ] }
  let(:pull_request_user) { OpenStruct.new(avatar_url: 'avatar_url') }
  let(:pull_requests) { [ OpenStruct.new(id: '123', number: 123, state: 'open', title: 'title', body: 'body', author: 'test_user', user: pull_request_user) ] }

  scenario 'fetch and display data for user from GitHub API' do
    login_with_github

    ENV['GITHUB_ACCESS_TOKEN'] = token
    fake_octokit_client = double('fake octokit client')
    expect(fake_octokit_client).to receive(:organizations).and_return(organizations)
    expect(fake_octokit_client).to receive(:org_repos).and_return(org_repos)
    expect(fake_octokit_client).to receive(:pull_requests).with('repo_1').and_return(pull_requests)
    expect(Octokit::Client).to receive(:new).with(access_token: token)
                              .and_return(fake_octokit_client)

    click_on 'Download data'
    expect(page).to have_css('img[src="https://test_org.com/name"]')    
    
    click_link('org-avatar')
    expect(page).to have_content('Repositories')

    click_link('repo')
    expect(page).to have_content('Pull requests')
  end
end
 
