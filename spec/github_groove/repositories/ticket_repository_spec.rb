require 'spec_helper'

describe TicketRepository do
  before do
    TicketRepository.clear
    ProjectRepository.clear

    project = ProjectRepository.create(Project.new(groove_access_token: "aaa"))
    TicketRepository.create(Ticket.new(title: "Need help", number: 1, project_id: project.id))
  end

  describe ".find_by_number" do
    it "finds ticket by number" do
      ticket = TicketRepository.find_by_number(1)
      ticket.title.must_equal "Need help"
    end

    it "returns nil" do
      TicketRepository.find_by_number(2).must_be_nil
    end
  end

  describe ".create_or_update_from_resource" do
    it "updates existing ticket by number" do
      resource = OpenStruct.new(title: "App broken", number: 1)

    end

    it "creates new ticket by number" do
      resource = OpenStruct.new(title: "App broken", number: 1)

    end
  end
end
