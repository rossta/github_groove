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
      issue.github_id.must_equal 101
      issue.github_number.must_equal 1347
      issue.github_state.must_equal "open"
      issue.github_url.length.must_be :>, 0
      issue.github_url.must_equal github_issue_response["html_url"]
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
