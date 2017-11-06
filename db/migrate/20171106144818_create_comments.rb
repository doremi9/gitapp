class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.string :gif_url
      t.references :pull_request, foreign_key: true

      t.timestamps
    end
  end
end
