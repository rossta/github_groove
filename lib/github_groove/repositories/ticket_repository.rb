class TicketRepository
  include Hanami::Repository

  def self.find_by_number(number)
    query do
      where(number: number)
    end.first
  end

  def self.create_or_update_from_resource(resource)
    found = find_by_number(resource.number)
    attrs = resource.to_h.slice(:title, :priority, :number, :summary)
    if found
      found.update(attrs)
      update found
    else
      create(Ticket.new(attrs))
    end
  end
end
