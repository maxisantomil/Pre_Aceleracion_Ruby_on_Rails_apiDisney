class Movie < ApplicationRecord
    has_many :character_movies, dependent: :destroy
    has_many :characters, through: :character_movies

    has_many :genre_movies, dependent: :destroy
    has_many :genres, through: :genre_movies

    validates :titulo , presence: true, length: { minimum:4 }
    validates :url_imagen , presence: true
    validates :calificacion, inclusion: { in: (1..5),message: "no es valida la calificacion"}
end
