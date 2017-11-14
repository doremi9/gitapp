require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  
  let(:auth_hash) { OmniAuth.config.mock_auth[:github] }
  
  context "given a user signs in for the first time" do
    it "creates a new user with GitHub account" do
      login_with_github
      expect{create_or_find_user(auth_hash)}.to change{User.count}.by(1)
      expect(page).to have_content("Log out")
    end
  end

  context "given existing user signs in" do
    it "does not create a new user" do
      login_with_github
      expect{create_or_find_user(auth_hash)}.to_not change{User.count}
      expect(page).to have_content("Log out")
    end 
  end

  context "unauthenticated user" do
    it "should not have access to organization repositories" do
      visit root_url
      expect(page).not_to have_content('Organizations')
      expect(page).not_to have_content('Log out')
    end
  end

end
