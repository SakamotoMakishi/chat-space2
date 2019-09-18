class AddProfilToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :text, default: "", null: false
  end
end
