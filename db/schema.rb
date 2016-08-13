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

ActiveRecord::Schema.define(version: 20160812104753) do

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertises_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "expertise_id"
    t.index ["expertise_id"], name: "index_expertises_profile_models_on_expertise_id"
    t.index ["profile_model_id"], name: "index_expertises_profile_models_on_profile_model_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_languages_profile_models_on_language_id"
    t.index ["profile_model_id"], name: "index_languages_profile_models_on_profile_model_id"
  end

  create_table "profile_models", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.decimal  "chest"
    t.decimal  "waist"
    t.decimal  "hips"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "ayes_color_id"
    t.integer  "current_province_id"
    t.string   "gender"
    t.integer  "size_shoes"
    t.integer  "size_cloth"
    t.index ["ayes_color_id"], name: "index_profile_models_on_ayes_color_id"
    t.index ["current_province_id"], name: "index_profile_models_on_current_province_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "role",                   default: 0
    t.integer  "kind",                   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "profileable_type"
    t.integer  "profileable_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profileable_type", "profileable_id"], name: "index_users_on_profileable_type_and_profileable_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
