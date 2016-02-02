class Repo
  def initialize(attrs = {})
    @client = attrs.fetch(:client) { raise "Option required: :client" }
    @name = attrs.fetch(:name) { raise "Option required: :name" }
  end

  def resource
    @resource || fetch
  end

  def fetch
    @resource = @client.repo(@name)
  end
end
