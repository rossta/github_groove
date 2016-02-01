require 'spec_helper'
require_relative '../../../../apps/web/controllers/session/destroy'

describe Web::Controllers::Session::Destroy do
  let(:action) { Web::Controllers::Session::Destroy.new }
  let(:params) { {'omniauth.auth' => {}, 'warden' => warden, 'rack.session' => {} } }

  it "it redirects" do
    response = action.call(params)
    response[0].must_equal 302
  end

  it "logs out user" do
    assert_send([warden, :logout])
    action.call(params)
  end
end
