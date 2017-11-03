class CreatePullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_requests do |t|
      t.integer :pr_id
      t.integer :number
      t.string :state
      t.string :title
      t.string :body
      t.references :repository, foreign_key: true
    end
  end
end
