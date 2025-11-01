class AddUserIdToTasks < ActiveRecord::Migration[8.0]
  def change
    # İlk olarak null: true ile ekle
    add_reference :tasks, :user, null: true, foreign_key: true
    
    # Mevcut kayıtları ilk kullanıcıya ata (eğer varsa)
    if User.exists?
      first_user = User.first
      Task.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    # Sonra null: false yap
    change_column_null :tasks, :user_id, false
  end
end
