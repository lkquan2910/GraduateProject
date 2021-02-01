class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.integer :project_id
      t.integer :subdivision_id
      t.integer :block_id
      t.integer :floor_id
      t.integer :project_layout_id
      t.integer :level
      t.integer :real_estate_type
      t.string :product_type
      t.integer :certificate
      t.integer :use_term
      t.integer :furniture
      t.integer :furniture_quality
      t.string :statics
      t.float :density
      t.bigint :deposit
      t.integer :amount_of_floors
      t.integer :direction
      t.float :carpet_area
      t.float :built_up_area
      t.float :plot_area
      t.float :floor_area
      t.float :setback_front
      t.float :setback_behind
      t.text :handover_standards
      t.text :detail
      t.integer :living_room
      t.string :bedroom
      t.integer :bath_room
      t.integer :dining_room
      t.integer :multipurpose_room
      t.integer :mini_bar
      t.integer :drying_yard
      t.integer :kitchen
      t.integer :balcony
      t.integer :business_space
      t.integer :currency
      t.bigint :price
      t.bigint :sum_price
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :lock_version
      t.string :slug
      t.string :state
      t.json :images
      t.timestamps
    end

    add_index :products, :block_id
    add_index :products, [:code, :project_id], unique: true
    add_index :products, :code
    add_index :products, :floor_id
    add_index :products, :level
    add_index :products, :name
    add_index :products, :project_id
    add_index  :products, :subdivision_id

  end
end
