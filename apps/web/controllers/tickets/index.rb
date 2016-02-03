module Web::Controllers::Tickets
  class Index
    include Web::Action

    expose :project
    expose :tickets

    before :connected_to_groove!

    def call(params)
      @project = current_user.project
      @tickets = @project.tickets(page: (params[:page] || 0))
    end
  end
end
