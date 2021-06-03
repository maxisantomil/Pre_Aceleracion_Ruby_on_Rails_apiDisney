class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :url_imagen
      t.string :nombre
      t.integer :edad
      t.float :peso
      t.text :historia

      t.timestamps
    end
  end
end
