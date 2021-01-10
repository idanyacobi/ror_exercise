module Services
  module UserService
    extend self

    def sign_in(login_params)
      user = User.find_by(email: login_params[:email])
      if user.authenticate login_params[:password]
        user.token = SecureRandom.uuid
        user.save
        return user
      end
      nil
    end

    def sign_out(user)
      user.token = nil
      if user.save
        return true
      end
      nil
    end
  end
end