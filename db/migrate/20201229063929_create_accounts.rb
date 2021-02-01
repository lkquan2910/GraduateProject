class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email, default: ''
      t.string :encrypted_password, default: '', null: false
      t.string :full_name
      t.string :phone
      t.boolean :phone_verify, default: false
      t.string :identity_card
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
