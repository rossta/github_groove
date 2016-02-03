require "pry"

namespace :sync do
  desc "Sync most recent tickets with GrooveHQ"
  task tickets: :environment do
    client = Vendor::Groove.new
    client.tickets.each do |resource|
      TicketRepository.create_or_update_from_resource(resource)
    end

    puts TicketRepository.all.count
  end
end
