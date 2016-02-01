class Ticket
  include Hanami::Entity

  attributes :title, :priority, :number, :summary

  def self.from_api(resource)
    Ticket.new(
      title: resource.title,
      number: resource.number,
      summary: resource.summary,
      priority: resource.priority
    )
  end
end

# Hash from API
# {:created_at=>"2016-01-31T15:51:54Z",
#  :number=>8,
#  :priority=>"high",
#  :resolution_time=>nil,
#  :state=>"opened",
#  :title=>"Need help",
#  :updated_at=>"2016-01-31T19:51:35Z",
#  :assigned_group=>nil,
#  :closed_by=>nil,
#  :tags=>[],
#  :mailbox=>"Help Desk",
#  :message_count=>2,
#  :summary=>"App not working! (Test)"}
