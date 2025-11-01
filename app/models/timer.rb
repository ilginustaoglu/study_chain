class Timer < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  
  # Çalışma zamanını HH:MM:SS formatında döndürür
  def formatted_study_time
    format_seconds(seconds)
  end
  
  # Mola zamanını HH:MM:SS formatında döndürür
  def formatted_break_time
    format_seconds(break_seconds)
  end
  
  # Generic zaman formatlama metodu
  def formatted_time
    formatted_study_time
  end
  
  private
  
  def format_seconds(total_seconds)
    hrs = total_seconds / 3600
    mins = (total_seconds % 3600) / 60
    secs = total_seconds % 60
    format('%02d:%02d:%02d', hrs, mins, secs)
  end
end
