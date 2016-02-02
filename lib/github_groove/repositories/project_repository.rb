class ProjectRepository
  include Hanami::Repository

  def self.find_or_create_by_params(params)
    found = find_by_groove_access_token(params[:groove_access_token])

    if found
      found.update(params)
      update found
    else
      create(Project.new(params))
    end
  end

  def self.find_by_groove_access_token(groove_access_token)
    query do
      where(groove_access_token: groove_access_token)
    end.first
  end
end
