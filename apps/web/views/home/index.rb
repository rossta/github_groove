module Web::Views::Home
  class Index
    include Web::View

    def link_to_project
      act = current_user.project ? "Edit" : "Set up"
      link_to "#{act} your project", "/project"
    end
  end
end
