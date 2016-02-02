# Require this file for unit tests
ENV["HANAMI_ENV"] ||= "test"

require_relative "../config/environment"
require "minitest/autorun"
require "minitest/pride" # awesome colorful output
require "webmock/minitest"
require "pry"

require_relative "./support/omniauth"

Hanami::Application.preload!

module MiniTest
  class Spec
    before do
      UserRepository.clear
      TicketRepository.clear
      ProjectRepository.clear
    end

    def omniauth_params
      OmniAuth.config.mock_auth[:github].dup
    end

    def warden
      @warden ||= begin
                    opts = -> {
                      [404, { 'Content-Type' => 'text/plain' }, ['Not found!']]
                    }
                    manager = Warden::Manager.new(opts)
                    Warden::Proxy.new({'rack.session' => {}}, manager)
                  end
    end
  end
end
