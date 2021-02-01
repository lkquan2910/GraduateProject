class CreateLayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :layouts do |t|
      t.string :name
      t.string :image
      t.integer :project_id
      t.integer :subdivision_id
      t.integer :block_id
      t.integer :floor_ids, array: true
      t.integer :level
      t.integer :number_of_product

      t.timestamps
    end
  end
end
