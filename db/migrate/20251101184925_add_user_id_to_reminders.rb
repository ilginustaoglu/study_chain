class AddUserIdToReminders < ActiveRecord::Migration[8.0]
  def change
    add_reference :reminders, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      Reminder.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :reminders, :user_id, false
  end
end
