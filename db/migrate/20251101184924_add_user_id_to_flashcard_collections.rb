class AddUserIdToFlashcardCollections < ActiveRecord::Migration[8.0]
  def change
    add_reference :flashcard_collections, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      FlashcardCollection.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :flashcard_collections, :user_id, false
  end
end
