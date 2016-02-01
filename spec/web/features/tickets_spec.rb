require "features_helper"

describe "Tickets" do
  before do
    TicketRepository.clear
    ProjectRepository.clear
  end

  it "displays list of tickets" do
    project = ProjectRepository.create(Project.new(groove_access_token: "aaa"))
    TicketRepository.create(Ticket.new(title: 'Need help', number: 1, project_id: project.id))
    TicketRepository.create(Ticket.new(title: 'Having trouble', number: 2, project_id: project.id))

    visit "/tickets"

    within "#tickets" do
      assert page.has_css?('.ticket', count: 2), "Expected to find 2 tickets"
    end
  end
end
