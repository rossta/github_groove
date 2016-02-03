require "spec_helper"

describe TicketRepository do
  let(:project) { create_project }

  before do
    TicketRepository.create(Ticket.new(title: "Need help", number: 1, project_id: project.id))
  end

  describe ".find_by_project_and_number" do
    it "finds ticket by number" do
      ticket = TicketRepository.find_by_project_and_number(project, 1)
      ticket.title.must_equal "Need help"
    end

    it "returns nil" do
      TicketRepository.find_by_project_and_number(project, 2).must_be_nil
    end
  end
end
