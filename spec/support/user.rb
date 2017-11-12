module Features
  class UserService
    def create_or_find_user(omniauth_hash)
      User.find_or_create_by(
        login: omniauth_hash[:info][:name],
        uid: omniauth_hash[:uid],
        profile_image: omniauth_hash[:info][:image]
      )
    end
  end
end