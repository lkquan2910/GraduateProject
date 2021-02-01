class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phone_number
      t.string :second_phone_number
      t.integer :gender
      t.string :email
      t.string :identity_card
      t.integer :city_id
      t.text :address
      t.date :dob
      t.integer :data_source
      t.integer :customer_characteristic, array: true
      t.string :job
      t.string :property_ownership
      t.string :nationality
      t.string :financial_capability
      t.text :detail
      t.string :income
      t.string :position
      t.string :work_place
      t.integer :marital_status
      t.text :note
      t.string :state
      t.integer :created_by_id
      t.string :country_code
      t.string :facebook_uid

      t.timestamps
    end

    add_index :customers, :created_by_id
  end
end
