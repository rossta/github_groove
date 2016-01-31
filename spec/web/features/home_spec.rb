require "features_helper"

describe "Homepage" do
  it "is successful" do
    visit "/"

    page.body.must_include("Groove")
  end
end
