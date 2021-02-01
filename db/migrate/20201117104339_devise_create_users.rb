# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Custom TMS
      t.string :full_name, null: true
      t.integer :account_type, null: true

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip

      t.timestamps null: false
      # add more
      t.integer :role_id
      t.string :provider, default: 'email', null: false
      t.string :uid, default: '', null: false
      t.text :tokens
      t.boolean :allow_password_change, default: false
      t.boolean :deactivated, default: false
      t.boolean :is_superadmin, default: false
      t.string :ancestry
      t.integer :group_id
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmed_sent_at
      t.string :unconfirmed_email
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at
      t.string :avatar
      t.string :endpoint
      t.string :p256dh_key
      t.string :auth_key
      t.boolean :subscribe, default: false
      t.json :deal_search
      t.string :code
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :ancestry
    add_index :users, [:uid, :provider]
    # add_index :users, :unlock_token,         unique: true
  end
end
