class User
  include Hanami::Entity

  attributes :id, :github_id, :name, :nickname, :image, :email

  def display_name
    name.presence || nickname || "Friend"
  end
end
