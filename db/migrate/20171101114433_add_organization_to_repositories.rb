class AddOrganizationToRepositories < ActiveRecord::Migration[5.0]
  def change
    add_reference :repositories, :organization, foreign_key: true
  end
end
