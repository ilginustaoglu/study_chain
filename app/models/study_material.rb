class StudyMaterial < ApplicationRecord
  belongs_to :user
  has_many_attached :files
  
  validates :title, presence: true
end
