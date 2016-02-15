require_relative "../jobs/sync_tickets_job"
require_relative "../vendor/groove"

class Project
  include Hanami::Entity

  attributes :groove_access_token, :github_repository, :syncing

  def ready?
    groove_access_token.present? && github_repository.present?
  end

  def tickets(params = {})
    TicketRepository.all_by_project(self, params)
  end

  def default_issue_labels
    ['groove']
  end

  def background_sync!
    self.syncing = true
    ProjectRepository.update(self)

    SyncTicketsJob.perform_async(id)
  end

  def sync!
    client = Vendor::Groove.new
    client.tickets.each do |resource|
      TicketRepository.create_or_update_from_resource(self, resource)
    end

    if syncing
      self.syncing = false
      ProjectRepository.update(self)
    end

    self
  end
end
