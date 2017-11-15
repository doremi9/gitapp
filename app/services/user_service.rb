class UserService
  def call(auth)
    user = User.find_or_create_by(
      login: auth[:info][:nickname], 
      uid: auth[:uid],
      profile_image: auth[:info][:image]
    )
    if new_user?(user)
      user.update_attribute(:gh_webhook_token, SecureRandom.hex(10))
    end
    user
  end

  def new_user?(user)
    user.gh_webhook_token == nil
  end
end
