class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :description
      t.datetime :alarm_time
      t.boolean :is_active

      t.timestamps
    end
  end
end
