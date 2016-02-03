require "spec_helper"
require_relative "../../../../apps/web/controllers/session/failure"

describe Web::Controllers::Session::Failure do
  let(:action) { Web::Controllers::Session::Failure.new }
  let(:params) { { "omniauth.auth" => {}, "warden" => warden, "rack.session" => {} } }

  it "it redirects" do
    response = action.call(params)
    response[0].must_equal 404
  end

  it "logs out user" do
    assert_send([warden, :logout])
    action.call(params)
  end
end
