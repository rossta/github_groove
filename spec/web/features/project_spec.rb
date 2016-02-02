require "features_helper"

describe "Project" do
  before do
    ProjectRepository.clear
    UserRepository.clear
  end

  describe "logged-in user" do
    before do
      visit "/"
      click_link "Sign in"
    end

    it "can create project" do
      click_link "Set up your project"

      within "form" do
        fill_in "Groove access token", with: "aabbcc"
        fill_in "Github repository", with: "rossta/github_groove"
        click_button "Save"
      end

      page.must_have_content("saved")
      page.must_have_content("keep your token private")

      user = UserRepository.first
      user.project.groove_access_token.must_equal "aabbcc"
      user.project.github_repository.must_equal "rossta/github_groove"
    end

    it "does not duplicate project by groove token" do
      project = ProjectRepository.create(Project.new(groove_access_token: "aabbcc"))
      UserRepository.update_user_project(UserRepository.first, project)

      visit "/"
      click_link "Edit your project"

      within "form" do
        fill_in "Groove access token", with: "aabbcc"
        fill_in "Github repository", with: "rossta/github_groove"
        click_button "Save"
      end

      page.must_have_content("saved")
      page.must_have_content("keep your token private")

      ProjectRepository.all.count.must_equal 1
    end
  end
end
