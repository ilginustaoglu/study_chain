class AddUserIdToTimers < ActiveRecord::Migration[8.0]
  def change
    add_reference :timers, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      Timer.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :timers, :user_id, false
  end
end
