require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  
  let(:auth_hash) { OmniAuth.config.mock_auth[:github] }
  
  context "given a user signs in for the first time" do
    it "creates a new user with GitHub account" do
      login_with_github
      expect(page).to have_content('You have successfully signed in!')
      expect(page).to have_content("Log out")
      expect(page).to have_content("Settings")
      expect(page).not_to have_content('Sign up with Github')
    end
  end

  context "given existing user signs in" do
    it "does not create a new user" do
      login_with_github
      expect(page).to have_content("Log out")
      expect(page).not_to have_content('Sign up with Github')
      expect(User.count) == 1
      click_link 'Log out'
      expect(page).to have_content('You have successfully signed out!')
      login_with_github
      expect(User.count) == 1
    end 
  end

  context "not logged in user enters url manualy in the browser" do
    it "should display an error" do
      visit root_url
      visit 'organizations/1'
      expect(page).to have_content('You must be logged in to access this section')
      expect(page).to have_content('Sign up with Github')
      expect(page).not_to have_content('Organizations')
      expect(page).not_to have_content('Log out')
    end
  end

  context "user logs out" do
    it "should display a message 'You have successfully signed out!" do
      login_with_github
      click_link 'Log out'
      expect(page).to have_content('You have successfully signed out!')
      expect(page).to have_content('Sign up with Github')
    end
  end

end
