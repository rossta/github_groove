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
      IssueRepository.clear
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

    def github_issue_response
      {
        "id" => 101,
        "url" => "https://api.github.com/repos/rossta/github_groove/issues/1347",
        "repository_url" => "https://api.github.com/repos/rossta/github_groove",
        "labels_url" => "https://api.github.com/repos/rossta/github_groove/issues/1347/labels{/name}",
        "comments_url" => "https://api.github.com/repos/rossta/github_groove/issues/1347/comments",
        "events_url" => "https://api.github.com/repos/rossta/github_groove/issues/1347/events",
        "html_url" => "https://github.com/rossta/github_groove/issues/1347",
        "number" => 1347,
        "state" => "open",
        "title" => "Found a bug",
        "body" => "I'm having a problem with this.",
        "user" => {},
        "labels" => [
          {
            "url" => "https://api.github.com/repos/rossta/github_groove/labels/bug",
            "name" => "bug",
            "color" => "f29513"
          }
        ],
        "assignee" => {},
        "milestone" => {},
        "locked" => false,
        "comments" => 0,
        "pull_request" => {},
        "closed_at" => nil,
        "created_at" => "2011-04-22T13 =>33 =>48Z",
        "updated_at" => "2011-04-22T13 =>33 =>48Z"
      }
    end

    def stub_github_issue_request(ticket)
      stub_request(
        :post,
        "https://api.github.com/repos/rossta/github_groove/issues").
        with(
          :body => "{\"labels\":[\"groove\"],\"title\":\"Need help\",\"body\":\"\\n\\n[View more info on Github/Groove](http://0.0.0.0:2300/tickets/#{ticket.id})\"}",
          :headers => {
            'Accept'=>'application/vnd.github.beta+json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'token aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            'User-Agent'=>'Octokit Ruby Gem 2.1.1'
          }
        ).to_return(
          :status => 200,
          :body => github_issue_response.to_json,
          :headers => {'Content-Type' => 'application/json'})
    end
  end
end
