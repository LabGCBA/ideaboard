class CreateCategoria < ActiveRecord::Migration
  def change
    create_table :categoria do |t|
      t.string :nombre, limit: 50, null: false

      t.timestamps null: false
    end
  end
end
