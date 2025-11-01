class AddUserIdToAgendas < ActiveRecord::Migration[8.0]
  def change
    add_reference :agendas, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      Agenda.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :agendas, :user_id, false
  end
end
