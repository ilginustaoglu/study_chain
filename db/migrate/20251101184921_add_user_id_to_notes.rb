class AddUserIdToNotes < ActiveRecord::Migration[8.0]
  def change
    add_reference :notes, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      Note.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :notes, :user_id, false
  end
end
