require "features_helper"

describe "Tickets" do
  describe "authenticated" do
    let(:user) { authenticated_user }
    let(:project) { create_project }

    before do
      user.project_id = project.id
      UserRepository.update(user)
      sign_in
    end

    it "displays list of tickets" do
      create_ticket(title: "Need help", number: 1, project_id: project.id)
      create_ticket(title: "Having trouble", number: 2, project_id: project.id)

      visit "/tickets"

      within "#tickets" do
        assert page.has_css?('.ticket', count: 2), "Expected to find 2 tickets"
      end
    end

    it "syncs with GrooveHQ in the background" do
      ticket_data = { "tickets" => [
        { title: "Need help", number: 1 },
        { title: "Having trouble", number: 2 },
      ]}
      stub_request(:get, "https://api.groovehq.com/v1/tickets").
        to_return(:status => 200, :body => ticket_data.to_json, :headers => {})

      visit "/tickets"

      click_link "Sync"

      within "#tickets" do
        assert page.has_css?('.ticket', count: 2), "Expected to find 2 tickets"
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
  end
end
