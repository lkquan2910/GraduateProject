class CreateDeposits < ActiveRecord::Migration[5.2]
  def change
    create_table :deposits do |t|
      t.string :name
      t.integer :customer_id
      t.integer :product_id
      t.integer :user_id
      t.string :product_code
      t.float :area
      t.integer :direction
      t.bigint :price
      t.bigint :total_price
      t.bigint :deposit
      t.bigint :total_price_after_discount
      t.bigint :commission
      t.string :state

      t.timestamps
    end
  end
end
