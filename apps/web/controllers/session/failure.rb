module Web::Controllers::Session
  class Failure
    include Web::Action

    def call(params)
      status 404, "Not found"
    end
  end
end
