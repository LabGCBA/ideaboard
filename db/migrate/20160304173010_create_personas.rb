class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :nombre, limit: 150
      t.string :apellido, limit: 150
      
      t.references :direccion
      t.timestamps null: false
    end
  end
end
