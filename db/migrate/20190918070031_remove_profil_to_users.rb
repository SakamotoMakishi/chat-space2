class RemoveProfilToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :profil, :text
  end
end
