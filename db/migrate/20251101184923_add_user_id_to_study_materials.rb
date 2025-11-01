class AddUserIdToStudyMaterials < ActiveRecord::Migration[8.0]
  def change
    add_reference :study_materials, :user, null: true, foreign_key: true
    
    if User.exists?
      first_user = User.first
      StudyMaterial.where(user_id: nil).update_all(user_id: first_user.id)
    end
    
    change_column_null :study_materials, :user_id, false
  end
end
