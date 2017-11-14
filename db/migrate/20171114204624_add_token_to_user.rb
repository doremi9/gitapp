class AddTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gh_webhook_token, :string
  end
end
