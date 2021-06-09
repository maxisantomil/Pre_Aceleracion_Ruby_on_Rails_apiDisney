class Character < ApplicationRecord
    has_many :character_movies, dependent: :destroy
    has_many :movies, through: :character_movies

    validates :nombre, presence: true, length: { minimum:4 }
    validates :edad, presence: true
    validates :peso, presence: true
    validates :historia, presence: true, length: { minimum:6 } #a modo de ejemplo minimo 6 
end
