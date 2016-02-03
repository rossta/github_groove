class Project
  include Hanami::Entity

  attributes :groove_access_token, :github_repository, :syncing

  def tickets
    TicketRepository.all_by_project(self)
  end

  def background_sync!
    self.syncing = true
    ProjectRepository.update(self)

    SyncTicketsJob.perform_async(self.id)
  end

  def sync!
    client = Vendor::Groove.new
    client.tickets.each do |resource|
      TicketRepository.create_or_update_from_resource(self, resource)
    end

    if self.syncing
      self.syncing = false
      ProjectRepository.update(self)
    end

    self
  end
end
