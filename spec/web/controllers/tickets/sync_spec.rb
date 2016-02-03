require "spec_helper"
require_relative "../../../../apps/web/controllers/tickets/sync"

describe Web::Controllers::Tickets::Sync do
  let(:action) { Web::Controllers::Tickets::Sync.new }
  let(:params) { { "omniauth.auth" => {}, "warden" => warden } }

  describe "authenticated" do
    before do
      user = UserRepository.create(
        User.new(github_id: 123, nickname: "rossta", github_access_token: "aaa")
      )
      warden.set_user user
    end

    it "is successful" do
      response = action.call(params)
      response[0].must_equal 302
    end
  end

  describe "visitor" do
    it "throws warden" do
      -> { action.call(params) }.must_throw :warden
    end
  end
end
