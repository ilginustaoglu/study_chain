class AddPomodoroTrackingToTimers < ActiveRecord::Migration[6.1]
  def change
    add_column :timers, :pomodoro_count, :integer
    add_column :timers, :session_type, :string
  end
end
