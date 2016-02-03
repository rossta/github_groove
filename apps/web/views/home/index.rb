module Web::Views::Home
  class Index
    include Web::View

    def link_to_project
      text = current_user.project ? "Project settings" : "Set up your project"
      link_to text, "/project"
    end

    def link_to_tickets
      link_to "View your tickets", "/tickets"
    end
  end
end
