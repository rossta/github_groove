module Web::Controllers::Issues
  class Create
    include Web::Action

    before :authenticate!
    before :project_ready!

    def call(params)
      @ticket = TicketRepository.find(params[:ticket_id])
      @issue = @ticket.create_issue(current_user.repo)

      redirect_to routes.ticket_path(@ticket.id)
    end
  end
end
