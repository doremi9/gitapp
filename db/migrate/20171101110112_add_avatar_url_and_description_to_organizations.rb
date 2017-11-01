class AddAvatarUrlAndDescriptionToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :avatar_url, :string
    add_column :organizations, :description, :string
  end
end
