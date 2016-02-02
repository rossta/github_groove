class User
  include Hanami::Entity

  attributes :id, :github_id, :name, :nickname, :image, :email, :project_id

  def display_name
    name.presence || nickname || "Friend"
  end

  def project
    return nil unless project_id

    @project ||= ProjectRepository.find(project_id)
  end
end
