class CreateDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :parent_id
      t.integer :project_id
      t.integer :label
      t.integer :level

      t.timestamps
    end
  end
end
