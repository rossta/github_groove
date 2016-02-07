class IssueRepository
  include Hanami::Repository

  # attributes :github_id, :github_url, :github_state, :ticket_id
  def self.create_from_api(ticket, resource)
    issue = Issue.new(
      ticket_id: ticket.id,
      github_id: resource.id.to_s,
      github_url: resource.rels[:self].href,
      github_state: resource.state
    )
    create(issue)
  end
end
