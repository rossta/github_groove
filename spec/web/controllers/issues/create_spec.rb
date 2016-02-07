require 'spec_helper'
require_relative '../../../../apps/web/controllers/issues/create'

describe Web::Controllers::Issues::Create do
  let(:action) { Web::Controllers::Issues::Create.new }
  let(:params) { Hash[] }

  let(:params) { Hash["warden" => warden] }

  describe "authenticated" do
    let(:project) { create_project }
    let(:ticket) { create_ticket(project_id: project.id) }

    let(:issue_params) { Hash[ticket_id: ticket.id] }

    def issue_response
      {
        "id" => 1,
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
          :body => issue_response.to_json,
          :headers => {'Content-Type' => 'application/json'})
    end

    before do
      stub_github_issue_request(ticket)
      user = authenticated_user
      UserRepository.update_user_project(user, project)
      warden.set_user user
    end

    it "redirects" do
      response = action.call(params.merge(issue_params))
      response[0].must_equal 302
    end

    it "creates issue" do
      action.call(params.merge(issue_params))
      IssueRepository.all.count.must_equal 1
      issue = IssueRepository.last
      issue.ticket_id.must_equal ticket.id
      issue.github_id.must_equal 1
      issue.github_url.must_equal "https://api.github.com/repos/rossta/github_groove/issues/1347"
      issue.github_state.must_equal "open"
    end
  end

  describe "visitor" do
    it "redirects" do
      -> { action.call(params) }.must_throw :warden
    end

    it "does not create issue" do
      catch(:warden) { action.call(params) }
      IssueRepository.all.count.must_equal 0
    end
  end
end
