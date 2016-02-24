module Web::Controllers::Tickets
  class Show
    include Web::Action

    expose :project
    expose :ticket

    before :assert_project_ready!

    def call(params)
      @project = current_user.project
      @ticket  = TicketRepository.find_project_ticket(@project, params[:id]) or status 404, "Not found"
    end
  end
end
