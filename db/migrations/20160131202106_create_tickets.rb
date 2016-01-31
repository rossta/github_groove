Hanami::Model.migration do
  change do
    create_table :tickets do
      primary_key :id

      column :title, String, null: false
      column :priority, String
      column :number, Integer, null: false
      column :summary, "text[]"
    end
  end
end
