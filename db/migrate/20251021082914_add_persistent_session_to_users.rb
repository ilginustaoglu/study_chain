class AddPersistentSessionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :persistent_session, :boolean, default: false, null: false
  end
end
