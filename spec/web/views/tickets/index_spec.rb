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
  end
end
