module Web::Controllers::Tickets
  class Sync
    include Web::Action

    before :authenticate!
    before :connected_to_groove!

    def call(params)
      flash[:message] = "Syncing in progress"

      current_user.project.background_sync!

      redirect_to "/tickets"
    end
  end
end
