Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :nickname, String, null: false
      column :github_id, String, null: false
      column :github_access_token, String, null: false
      column :name, String
      column :image, String
      column :email, String
    end
  end
end
