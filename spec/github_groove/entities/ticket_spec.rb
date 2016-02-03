require "spec_helper"

describe Ticket do
  it "can be initialized with attributes" do
    ticket = Ticket.new(title: "Need help")
    ticket.title.must_equal "Need help"
  end
end
