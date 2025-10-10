class CreateStudyMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :study_materials do |t|
      t.string :title
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
