class AddColumnsToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :identity_url, :string
  end
end
