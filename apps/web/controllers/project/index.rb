module Web::Controllers::Project
  class Index
    include Web::Action

    expose :project

    before :authenticate!

    def call(params)
      @project = current_user.project || Project.new
    end
  end
end
