class CreateRegionDatas < ActiveRecord::Migration[5.2]
  def change
    create_table :region_datas do |t|
      t.string :region_type
      t.string :slug
      t.integer :parent_id
      t.string :name
      t.string :name_with_type
      t.string :path
      t.string :path_with_type
      t.string :code

      t.timestamps
    end
  end
end
