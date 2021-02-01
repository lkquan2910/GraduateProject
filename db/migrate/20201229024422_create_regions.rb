class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.integer :city_id
      t.integer :district_id
      t.integer :ward_id
      t.belongs_to :objectable, polymorphic: true
      t.text :street

      t.timestamps
    end

    add_index :regions, :objectable_id
    add_index :regions, :objectable_type
  end
end
