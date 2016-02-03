class TicketRepository
  include Hanami::Repository
  include GithubGroove::Repositories::Pagination

  def self.find_by_project_and_number(project, number)
    query do
      where(number: number, project_id: project.id)
    end.first
  end

  def self.create_or_update_from_resource(project, resource)
    found = find_by_project_and_number(project, resource.number)
    attrs = resource.to_h.slice(:title, :priority, :number, :summary)

    if found
      found.update(attrs)
      update found
    else
      create(Ticket.new(attrs.merge(project_id: project.id)))
    end
  end

  def self.all_by_project(project, params = {})
    query do
      where(project_id: project.id).desc(:number)
    end.all
  end
end
