module Web::Controllers::Session
  class New
    include Web::Action

    def call(_params)
      user = UserRepository.from_omniauth(request.env["omniauth.auth"])

      warden.set_user user

      redirect_to "/"
    end

    def warden
      request.env["warden"]
    end
  end
end
