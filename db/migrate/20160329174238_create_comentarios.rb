class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :texto, limit: 600, null: false
      
      t.references :idea
      t.references :persona
      t.timestamps null: false
    end
  end
end
