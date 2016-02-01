require "features_helper"

describe "Authentication" do
  before do
    UserRepository.clear
  end

  it "via GitHub" do
    visit "/"

    click_link "Login with Github"

    page.has_content?("rossta")
  end
end
