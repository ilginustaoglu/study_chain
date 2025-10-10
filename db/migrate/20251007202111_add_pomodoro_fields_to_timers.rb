class AddPomodoroFieldsToTimers < ActiveRecord::Migration[6.1]
  def change
    add_column :timers, :timer_type, :string
    add_column :timers, :target_duration, :integer
  end
end
