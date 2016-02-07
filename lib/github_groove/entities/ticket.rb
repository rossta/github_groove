class Ticket
  include Hanami::Entity

  attributes :title, :priority, :number, :summary, :project_id

  def self.from_api(resource)
    Ticket.new(
      title: resource.title,
      number: resource.number,
      summary: resource.summary,
      priority: resource.priority
    )
  end

  def project
    return nil unless project_id

    @project ||= ProjectRepository.find(project_id)
  end

  def issue
    @project ||= IssueRepository.find_issue_by_ticket_id(id)
  end

  def create_issue(repo)
    resource = repo.create_issue(*to_issue_data)
    IssueRepository.create_from_api(self, resource)
  end

  def to_issue_data
    [title, issue_summary, labels: project.default_issue_labels]
  end

  # Append link for Github/Groove ticket page
  # to Github summary
  #
  def issue_summary
    footer = "\n\n[View more info on Github/Groove](#{Web::Routes.ticket_url(id)})"
    [summary, footer].compact.join
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
