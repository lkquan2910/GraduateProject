class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.string :name
      t.integer :customer_id
      t.integer :product_id
      t.string :state
      t.text :demand
      t.integer :assignee_id
      t.bigint :commission
      t.bigint :total_price
      t.integer :source
      t.text :labels, default: [], array: true
      t.integer :contact_status
      t.integer :interest_level
      t.integer :interaction_status
      t.text :financial_capability
      t.text :demand_for_advances
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :project_id
      t.text :trouble_problem
      t.datetime :assigned_at
      t.integer :position
      t.integer :interaction_detail, array: true
      t.integer :canceled_reason
      t.text :canceled_note
      t.string :reason_not_recall
      t.integer :trouble_problem_list, default: [], array: true
      t.datetime :state_changed_at
      t.integer :purchase_purpose
      t.integer :product_type
      t.text :balcony_direction, array: true
      t.string :interested_product
      t.string :second_phone_number
      t.integer :gender
      t.string :email
      t.string :identity_card
      t.integer :city_id
      t.integer :district_id
      t.integer :ward_id
      t.string :street
      t.integer :yob
      t.text :property_ownership
      t.string :nationality
      t.float :financial_capability_number
      t.string :customer_position
      t.string :nation
      t.string :domicile
      t.string :workplace
      t.string :settlements
      t.integer :marital_status
      t.string :people_in_family
      t.text :physical_appearance
      t.text :personality
      t.text :hobby
      t.text :positions_to_invest
      t.integer :real_estate_type_to_invest
      t.string :sub_source
      t.string :suggestive_name
      t.text :door_direction, default: [], array: true
      t.bigint :maintenance_fee
      t.bigint :discount
      t.bigint :product_price
      t.datetime :contract_signed_at
      t.bigint :manager_comm
      t.bigint :leader_comm
      t.bigint :admin_comm
      t.bigint :member_comm
      t.integer :lock_version, default: 0, null: false
      t.datetime :deleted_at
      t.string :pre_state
      t.datetime :cached_at
      t.boolean :is_external_project
      t.string :external_project
      t.string :code
      t.boolean :from_website

      t.timestamps
    end
  end
end
