class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :created_by_id
      t.text :content
      t.string :objectable_type
      t.integer :objectable_id
      t.boolean :is_third_holding
      t.datetime :deleted_at
      t.boolean :is_customer_note
      
      t.timestamps
    end

    add_index :notes, :objectable_id
    add_index :notes, :objectable_type
    add_index :notes, :deleted_at
  end
end
