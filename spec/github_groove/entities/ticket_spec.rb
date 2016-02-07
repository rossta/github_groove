require "spec_helper"

describe Ticket do
  let(:ticket) { Ticket.new(title: "Need help", number: 1, summary: "Summary", priority: "high") }

  it "can be initialized with attributes" do
    ticket = Ticket.new(title: "Need help")
    ticket.title.must_equal "Need help"
  end

  describe "#project" do
    it { ticket.project.must_be_nil }

    it "with project" do
      project = create_project

      ticket.project_id = project.id
      TicketRepository.create(ticket)
      ticket.project.must_equal project
    end
  end
end
