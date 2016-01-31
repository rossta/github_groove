require "spec_helper"
require_relative "../../../../apps/web/controllers/tickets/index"

describe Web::Controllers::Tickets::Index do
  let(:action) { Web::Controllers::Tickets::Index.new }
  let(:params) { Hash[] }

  before do
    TicketRepository.clear

    @ticket = TicketRepository.create(Ticket.new(title: "Need help", number: 1))
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
