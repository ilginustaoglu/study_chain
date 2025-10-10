class Timer < ApplicationRecord
  validates :name, presence: true
  
  # Alarm süresini HH:MM formatında döndürür
  def alarm_time
    return nil if alarm_seconds.nil?
    hours = alarm_seconds / 3600
    minutes = (alarm_seconds % 3600) / 60
    format('%02d:%02d', hours, minutes)
  end
  
  # HH:MM formatındaki zamanı saniyeye çevirir
  def alarm_time=(time_string)
    return self.alarm_seconds = nil if time_string.blank?
    hours, minutes = time_string.split(':').map(&:to_i)
    self.alarm_seconds = (hours * 3600) + (minutes * 60)
  end
  
  # Zamanı HH:MM:SS formatında döndürür
  def formatted_time
    hrs = seconds / 3600
    mins = (seconds % 3600) / 60
    secs = seconds % 60
    format('%02d:%02d:%02d', hrs, mins, secs)
  end
end
