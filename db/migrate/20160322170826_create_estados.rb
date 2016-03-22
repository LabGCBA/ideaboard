class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :texto, limit: 350, null: false
      
      t.references :idea
      t.references :persona
      t.timestamps null: false
    end
  end
end
