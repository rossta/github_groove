class GithubClient
  def initialize(attrs = {})
    @access_token = attrs.fetch(:access_token) { raise "Option required: :access_token" }
  end

  def repo(*args)
    client.repo(*args)
  end

  def client
    @client ||= Octokit::Client.new(access_token: @access_token)
  end
end
