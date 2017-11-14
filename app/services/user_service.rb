class UserService

  def call(auth)
    User.find_or_create_by(
      login: auth[:info][:nickname], 
      uid: auth[:uid],
      profile_image: auth[:info][:image],
      gh_webhook_token: SecureRandom.hex(10)
    )
  end
end
