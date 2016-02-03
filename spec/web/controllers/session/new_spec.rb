require "spec_helper"
require_relative "../../../../apps/web/controllers/session/new"

describe Web::Controllers::Session::New do
  let(:action) { Web::Controllers::Session::New.new }
  let(:params) { { "omniauth.auth" => omniauth_params, "warden" => warden } }

  after do
    UserRepository.clear
  end

  it "is successful" do
    response = action.call(params)
    response[0].must_equal 302
  end
end
