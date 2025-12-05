# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_05_224822) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "fiscal_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "forma_pago", null: false
    t.string "metodo_pago", null: false
    t.string "razon_social", null: false
    t.string "regimen", null: false
    t.string "rfc", limit: 13, null: false
    t.datetime "updated_at", null: false
    t.string "uso_cfdi", null: false
    t.index ["rfc"], name: "index_fiscal_profiles_on_rfc", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ports", force: :cascade do |t|
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "uncode"
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "permission_id", null: false
    t.bigint "role_id", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "shipping_lines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "entity_id"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.bigint "role_id"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["entity_id"], name: "index_users_on_entity_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "shipping_line_id", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_line_id"], name: "index_vessels_on_shipping_line_id"
  end

  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "users", "roles"
  add_foreign_key "vessels", "shipping_lines"
end
