class SyncTicketsJob
  include SuckerPunch::Job

  def perform(project_id)
    project = ProjectRepository.find(project_id)
    return unless project

    project.sync!
  end
end
