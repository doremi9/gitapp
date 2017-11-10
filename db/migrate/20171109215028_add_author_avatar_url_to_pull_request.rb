class AddAuthorAvatarUrlToPullRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :pull_requests, :author_avatar_url, :string
  end
end
