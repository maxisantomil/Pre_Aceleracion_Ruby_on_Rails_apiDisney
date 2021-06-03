class Character < ApplicationRecord
    has_many :character_movies, dependent: :destroy
    has_many :movies, through: :character_movies

    validates :nombre, presence: true
    validates :edad, presence: true
    validates :peso, presence: true
    validates :historia, presence: true
end
