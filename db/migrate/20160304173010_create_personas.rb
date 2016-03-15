class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :baid
      t.string :nombre, limit: 250
      
      t.references :direccion
      t.timestamps null: false
    end
  end
end
