class RemoveUrlFromRepos < ActiveRecord::Migration[5.0]
  def change
    remove_column :repos, :url, :string
  end
end
