require "features_helper"

describe "Tickets" do
  before do
    TicketRepository.clear
  end

  it "displays list of tickets" do
    TicketRepository.create(Ticket.new(title: 'Need help', number: 1))
    TicketRepository.create(Ticket.new(title: 'Having trouble', number: 2))

    visit "/tickets"

    within "#tickets" do
      assert page.has_css?('.ticket', count: 2), "Expected to find 2 tickets"
    end
  end
end
