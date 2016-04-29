class CreateEtapas < ActiveRecord::Migration
  def change
    create_table :etapas do |t|
      t.string :nombre, limit: 50, null: false
      
      t.timestamps null: false
    end
  end
end
