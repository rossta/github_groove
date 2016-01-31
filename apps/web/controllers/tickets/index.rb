module Web::Controllers::Tickets
  class Index
    include Web::Action

    expose :tickets

    def call(params)
      @tickets = TicketRepository.all
    end
  end
end
