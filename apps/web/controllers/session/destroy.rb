module Web::Controllers::Session
  class Destroy
    include Web::Action

    def call(params)
      warden.logout
      flash[:notice] = "You've been logged out"
      redirect_to "/"
    end
  end
end
