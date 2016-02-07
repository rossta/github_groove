Hanami::Model.migration do
  change do
    create_table :issues do
      primary_key :id

      column :github_id, String, null: false
      column :github_url, String, null: false
      column :github_state, String, null: false
      foreign_key :ticket_id, null: false

      index :ticket_id, unique: true
    end
  end
end
