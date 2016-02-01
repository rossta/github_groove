Hanami::Model.migration do
  change do
    create_table :projects do
      primary_key :id

      column :groove_access_token, String, null: false

      index :groove_access_token, unique: true
    end
  end
end
