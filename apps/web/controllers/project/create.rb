module Web::Controllers::Project
  class Create
    include Web::Action

    expose :project
    before :authenticate!

    params do
      param :project do
        param :groove_access_token, presence: true
        param :github_repository, presence: true
      end
    end

    def call(params)
      if params.valid?
        @project = ProjectRepository.find_or_create_by_params(params[:project])
        UserRepository.update_user_project(current_user, @project)

        flash[:notice] = "Your project has been saved!"

        redirect_to "/project"
      end
    end
  end
end
