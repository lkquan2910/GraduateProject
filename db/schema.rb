# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_18_065847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "phone"
    t.boolean "phone_verify", default: false
    t.string "identity_card"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "constructors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coordinates", force: :cascade do |t|
    t.integer "layout_id"
    t.integer "product_id"
    t.string "product_code"
    t.string "positions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "second_phone_number"
    t.integer "gender"
    t.string "email"
    t.string "identity_card"
    t.integer "city_id"
    t.text "address"
    t.date "dob"
    t.integer "data_source"
    t.integer "customer_characteristic", array: true
    t.string "job"
    t.string "property_ownership"
    t.string "nationality"
    t.string "financial_capability"
    t.text "detail"
    t.string "income"
    t.string "position"
    t.string "work_place"
    t.integer "marital_status"
    t.text "note"
    t.string "state"
    t.integer "created_by_id"
    t.string "country_code"
    t.string "facebook_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_customers_on_created_by_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string "name"
    t.integer "customer_id"
    t.integer "product_id"
    t.string "state"
    t.text "demand"
    t.integer "assignee_id"
    t.bigint "commission"
    t.bigint "total_price"
    t.integer "source"
    t.text "labels", default: [], array: true
    t.integer "contact_status"
    t.integer "interest_level"
    t.integer "interaction_status"
    t.text "financial_capability"
    t.text "demand_for_advances"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.integer "project_id"
    t.text "trouble_problem"
    t.datetime "assigned_at"
    t.integer "position"
    t.integer "interaction_detail", array: true
    t.integer "canceled_reason"
    t.text "canceled_note"
    t.string "reason_not_recall"
    t.integer "trouble_problem_list", default: [], array: true
    t.datetime "state_changed_at"
    t.integer "purchase_purpose"
    t.integer "product_type"
    t.text "balcony_direction", array: true
    t.string "interested_product"
    t.string "second_phone_number"
    t.integer "gender"
    t.string "email"
    t.string "identity_card"
    t.integer "city_id"
    t.integer "district_id"
    t.integer "ward_id"
    t.string "street"
    t.integer "yob"
    t.text "property_ownership"
    t.string "nationality"
    t.float "financial_capability_number"
    t.string "customer_position"
    t.string "nation"
    t.string "domicile"
    t.string "workplace"
    t.string "settlements"
    t.integer "marital_status"
    t.string "people_in_family"
    t.text "physical_appearance"
    t.text "personality"
    t.text "hobby"
    t.text "positions_to_invest"
    t.integer "real_estate_type_to_invest"
    t.string "sub_source"
    t.string "suggestive_name"
    t.text "door_direction", default: [], array: true
    t.bigint "maintenance_fee"
    t.bigint "discount"
    t.bigint "product_price"
    t.datetime "contract_signed_at"
    t.bigint "manager_comm"
    t.bigint "leader_comm"
    t.bigint "admin_comm"
    t.bigint "member_comm"
    t.integer "lock_version", default: 0, null: false
    t.datetime "deleted_at"
    t.string "pre_state"
    t.datetime "cached_at"
    t.boolean "is_external_project"
    t.string "external_project"
    t.string "code"
    t.boolean "from_website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.string "name"
    t.integer "customer_id"
    t.integer "product_id"
    t.integer "user_id"
    t.string "product_code"
    t.float "area"
    t.integer "direction"
    t.bigint "price"
    t.bigint "total_price"
    t.bigint "deposit"
    t.bigint "total_price_after_discount"
    t.bigint "commission"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "project_id"
    t.integer "label"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "layouts", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "project_id"
    t.integer "subdivision_id"
    t.integer "block_id"
    t.integer "floor_ids", array: true
    t.integer "level"
    t.integer "number_of_product"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_documents", force: :cascade do |t|
    t.integer "project_id"
    t.integer "doc_type"
    t.string "doc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "milestones", force: :cascade do |t|
    t.integer "project_id"
    t.string "event"
    t.date "event_time"
    t.boolean "is_default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer "created_by_id"
    t.text "content"
    t.string "objectable_type"
    t.integer "objectable_id"
    t.boolean "is_third_holding"
    t.datetime "deleted_at"
    t.boolean "is_customer_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_notes_on_deleted_at"
    t.index ["objectable_id"], name: "index_notes_on_objectable_id"
    t.index ["objectable_type"], name: "index_notes_on_objectable_type"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tag"
    t.text "content"
    t.datetime "read_at"
    t.string "related_url"
    t.datetime "deleted_at"
    t.integer "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_notifications_on_deleted_at"
  end

  create_table "operators", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_schedules", force: :cascade do |t|
    t.integer "project_id"
    t.integer "label_schedule"
    t.string "name"
    t.decimal "pay", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "role_id"
    t.boolean "can_edit", default: false
    t.boolean "can_edit_other", default: false
    t.boolean "can_create", default: false
    t.boolean "can_view", default: false
    t.boolean "can_view_other", default: false
    t.boolean "can_delete", default: false
    t.boolean "can_delete_other", default: false
    t.boolean "can_import", default: false
    t.boolean "change_state", default: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "project_id"
    t.integer "subdivision_id"
    t.integer "block_id"
    t.integer "floor_id"
    t.integer "project_layout_id"
    t.integer "level"
    t.integer "real_estate_type"
    t.string "product_type"
    t.integer "certificate"
    t.integer "use_term"
    t.integer "furniture"
    t.integer "furniture_quality"
    t.string "statics"
    t.float "density"
    t.bigint "deposit"
    t.integer "amount_of_floors"
    t.integer "direction"
    t.float "carpet_area"
    t.float "built_up_area"
    t.float "plot_area"
    t.float "floor_area"
    t.float "setback_front"
    t.float "setback_behind"
    t.text "handover_standards"
    t.text "detail"
    t.integer "living_room"
    t.string "bedroom"
    t.integer "bath_room"
    t.integer "dining_room"
    t.integer "multipurpose_room"
    t.integer "mini_bar"
    t.integer "drying_yard"
    t.integer "kitchen"
    t.integer "balcony"
    t.integer "business_space"
    t.integer "currency"
    t.bigint "price"
    t.bigint "sum_price"
    t.integer "created_by_id"
    t.integer "updated_by_id"
    t.integer "lock_version"
    t.string "slug"
    t.string "state"
    t.json "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_products_on_block_id"
    t.index ["code", "project_id"], name: "index_products_on_code_and_project_id", unique: true
    t.index ["code"], name: "index_products_on_code"
    t.index ["floor_id"], name: "index_products_on_floor_id"
    t.index ["level"], name: "index_products_on_level"
    t.index ["name"], name: "index_products_on_name"
    t.index ["project_id"], name: "index_products_on_project_id"
    t.index ["subdivision_id"], name: "index_products_on_subdivision_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "locking_time"
    t.decimal "construction_density", precision: 4, scale: 1
    t.decimal "total_area", precision: 10, scale: 2
    t.integer "real_estate_type", array: true
    t.integer "investors", array: true
    t.integer "constructors", array: true
    t.integer "developments", array: true
    t.integer "operators", array: true
    t.integer "features", array: true
    t.text "description"
    t.json "images"
    t.json "floorplan_images"
    t.integer "internal_utilities", array: true
    t.text "external_utilities"
    t.integer "ownership_period"
    t.boolean "foreigner"
    t.string "sale_policy"
    t.integer "banks", array: true
    t.decimal "loan_percentage_support", precision: 4, scale: 1
    t.integer "loan_support_period"
    t.integer "commission_type"
    t.decimal "commission", precision: 10, scale: 1
    t.integer "bonus"
    t.integer "high_level_number"
    t.integer "low_level_number"
    t.string "slug"
    t.decimal "price_from", precision: 10, scale: 2
    t.decimal "price_to", precision: 10, scale: 2
    t.decimal "area_from", precision: 10, scale: 2
    t.decimal "area_to", precision: 10, scale: 2
    t.text "custom_description"
    t.text "custom_sale_policy"
    t.text "custom_utilities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banks"], name: "index_projects_on_banks", using: :gin
    t.index ["constructors"], name: "index_projects_on_constructors", using: :gin
    t.index ["developments"], name: "index_projects_on_developments", using: :gin
    t.index ["features"], name: "index_projects_on_features", using: :gin
    t.index ["internal_utilities"], name: "index_projects_on_internal_utilities", using: :gin
    t.index ["investors"], name: "index_projects_on_investors", using: :gin
    t.index ["operators"], name: "index_projects_on_operators", using: :gin
    t.index ["real_estate_type"], name: "index_projects_on_real_estate_type", using: :gin
  end

  create_table "region_datas", force: :cascade do |t|
    t.string "region_type"
    t.string "slug"
    t.integer "parent_id"
    t.string "name"
    t.string "name_with_type"
    t.string "path"
    t.string "path_with_type"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.integer "city_id"
    t.integer "district_id"
    t.integer "ward_id"
    t.string "objectable_type"
    t.bigint "objectable_id"
    t.text "street"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["objectable_id"], name: "index_regions_on_objectable_id"
    t.index ["objectable_type", "objectable_id"], name: "index_regions_on_objectable_type_and_objectable_id"
    t.index ["objectable_type"], name: "index_regions_on_objectable_type"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.integer "account_type"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.boolean "allow_password_change", default: false
    t.boolean "deactivated", default: false
    t.boolean "is_superadmin", default: false
    t.string "ancestry"
    t.integer "group_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmed_sent_at"
    t.string "unconfirmed_email"
    t.string "access_token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.string "avatar"
    t.string "endpoint"
    t.string "p256dh_key"
    t.string "auth_key"
    t.boolean "subscribe", default: false
    t.json "deal_search"
    t.string "code"
    t.index ["ancestry"], name: "index_users_on_ancestry"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider"
  end

end
