class CreateCoordinates < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinates do |t|
      t.integer :layout_id
      t.integer :product_id
      t.string :product_code
      t.string :positions

      t.timestamps
    end
  end
end
