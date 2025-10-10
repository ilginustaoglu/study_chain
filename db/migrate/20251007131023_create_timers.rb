class CreateTimers < ActiveRecord::Migration[6.1]
  def change
    create_table :timers do |t|
      t.string :name, null: false
      t.integer :seconds, default: 0
      t.integer :alarm_seconds
      t.boolean :is_running, default: false

      t.timestamps
    end
  end
end
