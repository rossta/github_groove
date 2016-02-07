class Repo
  def initialize(attrs = {})
    @client = attrs.fetch(:client) { raise "Option required: :client" }
    @name = attrs.fetch(:name) { raise "Option required: :name" }
  end

  def resource
    @resource || fetch
  end

  def create_issue(title, body, opts = {})
    @client.create_issue(@name, title, body, opts)
  end

  def fetch
    @resource = @client.repo(@name)
  end
end
