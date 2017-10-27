class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.string :name
      t.string :url
      t.string :pull_requests_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
