require "features_helper"

describe "Tickets" do
  describe "authenticated" do
    let(:user) { authenticated_user }
    let(:project) { create_project }

    before do
      UserRepository.update_user_project(user, project)
      sign_in
    end

    it "displays list of tickets" do
      create_ticket(title: "Need help", number: 1, project_id: project.id)
      create_ticket(title: "Having trouble", number: 2, project_id: project.id)

      visit "/tickets"

      within "#tickets" do
        assert page.has_css?(".ticket", count: 2), "Expected to find 2 tickets"
      end
    end

    it "syncs with GrooveHQ in the background" do
      ticket_data = { "tickets" => [
        { title: "Need help", number: 1 },
        { title: "Having trouble", number: 2 }
      ] }
      stub_request(:get, "https://api.groovehq.com/v1/tickets").
        to_return(status: 200, body: ticket_data.to_json, headers: {})

      visit "/tickets"

      click_link "Sync"

      within "#tickets" do
        assert page.has_css?(".ticket", count: 2), "Expected to find 2 tickets"
      end
    end

    it "displays processing message" do
      project.syncing = true
      ProjectRepository.update(project)

      visit "/tickets"

      page.must_have_content("Background sync in progress. Please be patient")

      project.syncing = false
      ProjectRepository.update(project)

      visit "/tickets"

      page.wont_have_content("Background sync in progress. Please be patient")
    end

    it "creates a ticket on github" do
      ticket = create_ticket(title: "Need help", number: 1, project_id: project.id)
      stub_github_issue_request(ticket)

      visit "/tickets"

      within ".ticket" do
        click_button "Create Github issue"
      end

      page.must_have_content("View issue")

      ticket = TicketRepository.last
      ticket.number.must_equal 1

      issue = ticket.issue
      issue.github_id.must_equal 101 # github_issue_response["id"]
    end
  end
end
