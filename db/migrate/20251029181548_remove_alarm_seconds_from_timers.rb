class RemoveAlarmSecondsFromTimers < ActiveRecord::Migration[8.0]
  def change
    remove_column :timers, :alarm_seconds, :integer
  end
end
