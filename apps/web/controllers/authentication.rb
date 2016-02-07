module Web
  module Authentication
    def self.included(action)
      action.class_eval do
        expose :current_user
        expose :signed_in?
      end
    end

    def signed_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= warden.user
    end

    def warden
      request.env["warden"]
    end

    def authenticate!
      warden.authenticate!
    end

    def project_ready!
      return true if current_project_ready?

      flash[:message] = "Please connect with Groove and Github first"

      redirect_to "/project"
    end

    def current_project_ready?
      current_project && current_project.ready?
    end

    def current_project
      current_user && current_user.project
    end
  end
end
