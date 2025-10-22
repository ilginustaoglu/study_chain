class AddRememberMeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :remember_me_enabled, :boolean
  end
end
