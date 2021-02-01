class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :locking_time
      t.decimal :construction_density, precision: 4, scale: 1
      t.decimal :total_area, precision: 10, scale: 2
      t.integer :real_estate_type, array: true
      t.integer :investors, array: true
      t.integer :constructors, array: true
      t.integer :developments, array: true
      t.integer :operators, array: true
      t.integer :features, array: true
      t.text :description
      t.json :images
      t.json :floorplan_images
      t.integer :internal_utilities, array: true
      t.text :external_utilities
      t.integer :ownership_period
      t.boolean :foreigner
      t.string :sale_policy
      t.integer :banks, array: true
      t.decimal :loan_percentage_support, precision: 4, scale: 1
      t.integer :loan_support_period
      t.integer :commission_type
      t.decimal :commission, precision: 10, scale: 1
      t.integer :bonus, precision: 10, scale: 1
      t.integer :high_level_number
      t.integer :low_level_number
      t.string :slug
      t.decimal :price_from, precision: 10, scale: 2
      t.decimal :price_to, precision: 10, scale: 2
      t.decimal :area_from, precision: 10, scale: 2
      t.decimal :area_to, precision: 10, scale: 2
      t.text :custom_description
      t.text :custom_sale_policy
      t.text :custom_utilities

      t.timestamps
    end

    add_index :projects, :real_estate_type, using: 'gin'
    add_index :projects, :investors, using: 'gin'
    add_index :projects, :constructors, using: 'gin'
    add_index :projects, :developments, using: 'gin'
    add_index :projects, :operators, using: 'gin'
    add_index :projects, :features, using: 'gin'
    add_index :projects, :internal_utilities, using: 'gin'
    add_index :projects, :banks, using: 'gin'
  end
end
