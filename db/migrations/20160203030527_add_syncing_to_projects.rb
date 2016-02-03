Hanami::Model.migration do
  change do
    alter_table(:projects) do
      add_column :syncing, TrueClass, default: false
    end
  end
end
