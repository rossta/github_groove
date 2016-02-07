class IssueRepository
  include Hanami::Repository

  # attributes :github_id, :github_url, :github_state, :ticket_id
  def self.create_from_api(ticket, resource)
    issue = Issue.new(
      ticket_id: ticket.id,
      github_id: resource.id.to_s,
      github_number: resource.number.to_s,
      github_url: resource.rels[:self].href,
      github_state: resource.state
    )
    create(issue)
  end

  def self.find_issue_by_ticket_id(ticket_id)
    query do
      where(ticket_id: ticket_id)
    end.first
  end
end
