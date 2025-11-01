class Reminder < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  
  scope :active, -> { where(is_active: true) }
  scope :upcoming, -> { where('alarm_time > ?', Time.current).order(:alarm_time) }
end
