require "spec_helper"
require_relative "../../../../apps/web/controllers/tickets/index"

describe Web::Controllers::Tickets::Index do
  let(:action) { Web::Controllers::Tickets::Index.new }
  let(:params) { {'omniauth.auth' => {}, 'warden' => warden } }

  before do
    TicketRepository.clear
    ProjectRepository.clear

    project = ProjectRepository.create(Project.new(groove_access_token: "aaa"))
    @ticket = TicketRepository.create(Ticket.new(title: "Need help", number: 1, project_id: project.id))
  end

  it "is successful" do
    response = action.call(params)
    response[0].must_equal 200
  end

  it "exposes all tickets" do
    action.call(params)
    action.exposures[:tickets].must_equal [@ticket]
  end
end
