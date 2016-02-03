require "spec_helper"
require_relative "../../../../apps/web/views/tickets/index"

describe Web::Views::Tickets::Index do
  let(:exposures) { Hash[tickets: [], project: project] }
  let(:template)  { Hanami::View::Template.new("apps/web/templates/tickets/index.html.erb") }
  let(:view)      { Web::Views::Tickets::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:project) { ProjectRepository.create(Project.new(groove_access_token: "aaa")) }

  describe "authenticated" do
    let(:user) { authenticated_user }

    before do
      warden.set_user user
    end

    it "exposes #tickets" do
      view.tickets.must_equal exposures.fetch(:tickets)
    end

    describe "when there are no tickets" do
      it "shows a placeholder message" do
        rendered.must_include("<p class=\"placeholder\">There are no tickets yet.</p>")
      end
    end

    describe "when there are tickets" do
      let(:ticket1)     { Ticket.new(title: "Need help", number: 1) }
      let(:ticket2)     { Ticket.new(title: "App not working", number: 2) }
      let(:exposures) { Hash[tickets: [ticket1, ticket2], project: project] }

      it "lists them all" do
        rendered.scan(%r{class="ticket"}).count.must_equal 2
        rendered.must_include("Need help")
        rendered.must_include("App not working")
      end

      it "hides the placeholder message" do
        rendered.wont_include("<p class=\"placeholder\">There are no tickets yet.</p>")
      end
    end
  end
end
