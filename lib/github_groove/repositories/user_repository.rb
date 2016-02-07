class UserRepository
  include Hanami::Repository

  def self.find_by_github_id(github_id)
    query do
      where(github_id: github_id)
    end.first
  end

  def self.from_omniauth(omniauth)
    github_id = omniauth.uid
    found = find_by_github_id(github_id)

    attrs = {}
    attrs[:name] = omniauth.info.name
    attrs[:nickname] = omniauth.info.nickname
    attrs[:image] = omniauth.info.image
    attrs[:email] = omniauth.info.email || omniauth.extra.raw_info.email
    attrs[:github_access_token] = omniauth.credentials.token

    if found
      found.update(attrs)
      update found
    else
      create(User.new(attrs.merge(github_id: github_id)))
    end
  end

  def self.update_user_project(user, project)
    user.project_id = project.id
    update(user)
  end
end
