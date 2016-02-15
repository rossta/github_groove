module Web::Controllers::Tickets
  class Sync
    include Web::Action

    before :authenticate!
    before :project_ready!

    def call(_params)
      flash[:message] = "Syncing in progress"

      current_user.project.sync!

      redirect_to "/tickets"
    end
  end
end
