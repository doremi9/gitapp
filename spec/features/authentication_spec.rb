require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  
  let(:auth_hash) { OmniAuth.config.mock_auth[:github] }
  
  context "given a user signs in for the first time" do
    it "creates a new user with GitHub account" do
      login_with_github
      expect{Features::UserService.new.create_or_find_user(auth_hash)}.to change{User.count}.by(1)
    end
  end

  context "given existing user signs in" do
    it "does not create a new user" do
      login_with_github
      expect{Features::UserService.new.create_or_find_user(auth_hash)}.to_not change{User.count}
    end 
  end

end
