class Issue
  include Hanami::Entity

  attributes :github_id, :github_url, :github_state, :ticket_id
end
