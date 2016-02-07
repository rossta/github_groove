require "spec_helper"
require_relative "../../../../apps/web/controllers/tickets/index"

describe Web::Controllers::Tickets::Index do
  let(:action) { Web::Controllers::Tickets::Index.new }
  let(:params) { { "omniauth.auth" => {}, "warden" => warden } }

  describe "authenticated" do
    before do
      user = authenticated_user
      warden.set_user user

      @project = create_project
      UserRepository.update_user_project(user, @project)
      @ticket = create_ticket(title: "Need help", number: 1, project_id: @project.id)
    end

    it "is successful" do
      response = action.call(params)
      response[0].must_equal 200
    end

    it "exposes project tickets" do
      action.call(params)
      action.exposures[:tickets].must_equal [@ticket]
      action.exposures[:project].must_equal @project
    end
  end
end
