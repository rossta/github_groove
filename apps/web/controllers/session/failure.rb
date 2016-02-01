module Web::Controllers::Session
  class Failure
    include Web::Action

    def call(params)
      warden.logout
      flash[:notice] = "There was a problem logging you in"
      redirect_to "/"
    end
  end
end
