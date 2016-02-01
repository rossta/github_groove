Hanami::Model.migration do
  change do
    alter_table(:users) do
      add_foreign_key :project_id, :projects
    end
  end
end
