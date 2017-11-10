require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  
  describe "signs user in for the first time with GitHub" do
    it "creates a new user with Github account" do
      visit root_url
      click_link "Sign up with GitHub!"
      expect(User.count).to eql(1)
      expect(page).to have_content("You have successfully signed in!")
      expect(page).to have_content("Log out")
    end
  end

  describe "exisiting user" do
    it "does not create a new user" do
    end
  end
end
