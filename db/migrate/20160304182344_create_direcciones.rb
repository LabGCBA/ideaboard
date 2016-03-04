class CreateDirecciones < ActiveRecord::Migration
  def change
    create_table :direcciones do |t|
      t.string :nombre, limit: 150, null: false

      t.references :subsecretaria
      t.timestamps null: false
    end
  end
end
