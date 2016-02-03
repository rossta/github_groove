module Vendor
  class Groove
    def initialize
      require "groovehq"

      @client = GrooveHQ::Client.new
    end

    def tickets(*args)
      @client.tickets(*args)
    end
  end
end

