Hanami::Model.migration do
  change do
    alter_table(:projects) do
      add_column :github_repository, String
    end
  end
end
