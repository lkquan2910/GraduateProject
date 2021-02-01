class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.integer :role_id
      t.boolean :can_edit, default: false
      t.boolean :can_edit_other, default: false
      t.boolean :can_create, default: false
      t.boolean :can_view, default: false
      t.boolean :can_view_other, default: false
      t.boolean :can_delete, default: false
      t.boolean :can_delete_other, default: false
      t.boolean :can_import, default: false
      t.boolean :change_state, default: false
      t.string :name
      
      t.timestamps
    end
  end
end
