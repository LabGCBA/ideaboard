class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :texto, limit: 300, null: false
      
      t.references :persona
      t.references :categoria
      t.timestamps null: false
    end
  end
end
