class RenameRepos < ActiveRecord::Migration[5.0]
  def change
    rename_table :repos, :repositories
  end
end
