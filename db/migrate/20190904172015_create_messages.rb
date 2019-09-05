class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :group_id, foreign_key: true
      t.integer :user_id, foreign_key: true
      t.boolean :checked,default: false
      t.timestamps
    end
  end
end
