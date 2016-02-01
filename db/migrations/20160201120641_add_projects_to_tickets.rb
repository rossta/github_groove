Hanami::Model.migration do
  change do
    alter_table(:tickets) do
      add_foreign_key :project_id, :projects, null: false

      add_index [:project_id, :number], unique: true
    end
  end
end
