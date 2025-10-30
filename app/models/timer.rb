class Timer < ApplicationRecord
  validates :name, presence: true
  
  # Zamanı HH:MM:SS formatında döndürür
  def formatted_time
    hrs = seconds / 3600
    mins = (seconds % 3600) / 60
    secs = seconds % 60
    format('%02d:%02d:%02d', hrs, mins, secs)
  end
end
