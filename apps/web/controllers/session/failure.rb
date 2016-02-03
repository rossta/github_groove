module Web::Controllers::Session
  class Failure
    include Web::Action

    def call(_params)
      status 404, "Not found"
    end
  end
end
