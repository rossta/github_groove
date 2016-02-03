# Require this file for unit tests
ENV["HANAMI_ENV"] ||= "test"

require_relative "../config/environment"
require "minitest/autorun"
require "minitest/pride" # awesome colorful output
require "webmock/minitest"
require "pry"
require "sucker_punch/testing/inline"

require_relative "./support/omniauth"

Hanami::Application.preload!

module MiniTest
  class Spec
    before do
      UserRepository.clear
      TicketRepository.clear
      ProjectRepository.clear
    end

    def authenticated_user
      @authenticated_user ||= UserRepository.from_omniauth(omniauth_params)
    end

    def create_project(groove_access_token: "aabbcc", github_repository: "rossta/github_groove")
      ProjectRepository.create(
        Project.new(
          groove_access_token: groove_access_token,
          github_repository: github_repository))
    end

    def create_ticket(title: "Need help", number: 1, project_id: create_project.id)
      TicketRepository.create(
        Ticket.new(
          title: title,
          number: number,
          project_id: project_id))
    end

    def omniauth_params
      OmniAuth.config.mock_auth[:github].dup
    end

    def warden
      @warden ||= begin
                    opts = lambda do
                      [404, { "Content-Type" => "text/plain" }, ["Not found!"]]
                    end
                    manager = Warden::Manager.new(opts)
                    Warden::Proxy.new({ "rack.session" => {} }, manager)
                  end
    end
  end
end
