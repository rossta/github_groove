require "features_helper"

describe "Authentication" do
  before do
    UserRepository.clear
  end

  it "login via GitHub" do
    visit "/"

    click_link "Sign in with Github"

    page.must_have_content("Ross Kaffenberger")
  end

  it "via GitHub" do
    visit "/"

    click_link "Sign in with Github"
    click_link "Sign out"

    page.wont_have_content("Ross Kaffenberger")
  end
end
