class UserService

  def call(user_data)
    User.find_by(login: user_data[:login], uid: user_data[:uid]) || create_user(user_data)
  end

  private

  def create_user(user_data)
    User.create(
        uid: user_data[:uid],
        login: user_data[:login],
        profile_image: user_data[:image]
      )
  end
end