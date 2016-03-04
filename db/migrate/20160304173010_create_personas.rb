class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :miba_id
      t.string :email, limit: 100, null: false
      t.string :nombre, limit: 250, null: false
      
      t.references :direccion
      t.timestamps null: false
    end
  end
end
