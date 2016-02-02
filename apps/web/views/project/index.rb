module Web::Views::Project
  class Index
    include Web::View

    def value
      project.presence && project.groove_access_token
    end
  end
end
