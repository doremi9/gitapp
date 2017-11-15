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

  context "unauthenticated user" do
    it "should not have access to organization repositories" do
      visit root_url
      expect(page).to have_content('Sign up with Github')
      expect(page).not_to have_content('Organizations')
      expect(page).not_to have_content('Log out')
    end
  end

end
