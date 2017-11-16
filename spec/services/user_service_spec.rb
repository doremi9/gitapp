require 'rails_helper'

RSpec.describe UserService do
  let(:auth_hash) { OmniAuth.config.mock_auth[:github] }
  
  describe "User Service" do
    it "creates a new user with a token or finds an existing one in the database" do
      expect do
        user = UserService.new.call(auth_hash)
        expect(user.gh_webhook_token).not_to be_empty
      end.to change{User.count}.by(1)
    end
  end
end