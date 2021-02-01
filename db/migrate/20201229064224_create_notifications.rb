class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :tag
      t.text :content
      t.datetime :read_at
      t.string :related_url
      t.datetime :deleted_at
      t.integer :deal_id

      t.timestamps
    end

    add_index :notifications, :deleted_at
  end
end
