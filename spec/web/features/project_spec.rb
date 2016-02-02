require "features_helper"

describe "Project" do
  before do
    UserRepository.clear
  end

  describe "logged-in user" do
    before do
      visit "/"
      click_link "Sign in"
    end

    it "can create project" do
      click_link "Connect to Groove"

      within "form" do
        fill_in "Groove access token", with: "aabbcc"
        click_button "Save"
      end

      page.must_have_content("saved")
      page.must_have_content("keep your token private")

      user = UserRepository.first
      user.project.groove_access_token.must_equal "aabbcc"
    end
  end
end
