class FlashcardCollection < ApplicationRecord
  has_many :flashcards, dependent: :destroy
  
  validates :title, presence: true
end
