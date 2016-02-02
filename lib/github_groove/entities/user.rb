class User
  include Hanami::Entity

  attributes :id, :github_id, :name, :nickname, :image, :email, :project_id, :github_access_token

  def display_name
    name.presence || nickname || "Friend"
  end

  def project
    return nil unless project_id

    @project ||= ProjectRepository.find(project_id)
  end

  def repo
    return nil unless project && project.github_repository

    @repo ||= Repo.new(client: github_client, name: project.github_repository)
  end

  def github_client
    @github_client ||= GithubClient.new(access_token: github_access_token)
  end
end
