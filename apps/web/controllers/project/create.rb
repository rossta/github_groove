module Web::Controllers::Project
  class Create
    include Web::Action

    expose :project
    before :authenticate!

    params do
      param :project do
        param :groove_access_token,  presence: true
      end
    end

    def call(params)
      if params.valid?
        @project = ProjectRepository.create(Project.new(params[:project]))
        current_user.project_id = @project.id
        UserRepository.update(current_user)

        flash[:notice] = "Your project has been saved: #{current_user.project_id}"

        redirect_to "/project"
      end
    end
  end
end
