class AddOmniauthColumnsToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :provider, :string
    add_column :personas, :uid, :string
    add_column :personas, :name, :string
  end
end
