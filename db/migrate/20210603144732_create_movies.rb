class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :url_imagen
      t.string :titulo
      t.date :fecha_creacion
      t.integer :calificacion

      t.timestamps
    end
  end
end
