class AddBreakFieldsToTimers < ActiveRecord::Migration[8.0]
  def change
    add_column :timers, :break_seconds, :integer, default: 0, null: false
    add_column :timers, :active_timer, :string, default: 'study', null: false
  end
end
