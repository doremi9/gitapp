class AddUserRefsToPullRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :pull_requests, :user, foreign_key: true
  end
end
