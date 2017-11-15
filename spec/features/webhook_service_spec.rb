require 'rails_helper'

RSpec.feature "Webhook Service", type: :feature do
  let(:auth_hash) { OmniAuth.config.mock_auth[:github] }

  scenario 'registered user receives a webhook' do
    login_with_github
    expect(page).to have_content('You have successfully signed in!')

    visit settings_path
    expect(page).to have_content('Webhook URL:')
    
    token = page.find('b.token').text
    params = {
      gh_webhook_token: token,
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

    WebhookService.new.call(params)
    
    visit root_path
    expect(page).to have_css('img[src="http://test.com/name"]')

    click_on 'org-avatar'
    expect(page).to have_content('Repositories')
    
    click_on 'testname'
    expect(page).to have_content('Pull requests')

    click_on 'Pull requests'
    expect(page).to have_content('Title:')
    expect(page).to have_content('Hey, everything is OK!')
    expect(page).to have_css('img.gif')

  end
end