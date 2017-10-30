class RemovePullRequestsUrlFromRepos < ActiveRecord::Migration[5.0]
  def change
    remove_column :repos, :pull_requests_url, :string
  end
end
