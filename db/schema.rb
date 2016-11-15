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

ActiveRecord::Schema.define(version: 20161115164442) do

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.string   "profileable_type"
    t.integer  "profileable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "identifier"
    t.index ["identifier"], name: "index_albums_on_identifier"
    t.index ["profileable_type", "profileable_id"], name: "index_albums_on_profileable_type_and_profileable_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "status",                default: 0
    t.text     "description"
    t.text     "location"
    t.datetime "casting_date"
    t.datetime "shooting_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "profile_contractor_id"
    t.integer  "profile_model_id"
    t.index ["profile_contractor_id", "profile_model_id"], name: "index_bookings_on_profile_contractor_id_and_profile_model_id"
    t.index ["profile_contractor_id"], name: "index_bookings_on_profile_contractor_id"
    t.index ["profile_model_id"], name: "index_bookings_on_profile_model_id"
  end

  create_table "castings", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.datetime "expiration_date"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",          default: 0
    t.integer  "access_type",     default: 0
    t.datetime "casting_date"
    t.datetime "shooting_date"
    t.index ["ownerable_type", "ownerable_id"], name: "index_castings_on_ownerable_type_and_ownerable_id"
  end

  create_table "castings_categories", id: false, force: :cascade do |t|
    t.integer "casting_id"
    t.integer "category_id",      null: false
    t.integer "profile_model_id"
    t.index ["casting_id"], name: "index_castings_categories_on_casting_id"
    t.index ["profile_model_id"], name: "index_castings_categories_on_profile_model_id"
  end

  create_table "castings_modalities", id: false, force: :cascade do |t|
    t.integer "casting_id"
    t.integer "modality_id"
    t.index ["casting_id"], name: "index_castings_modalities_on_casting_id"
    t.index ["modality_id"], name: "index_castings_modalities_on_modality_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_es"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_profile_models_on_category_id"
    t.index ["profile_model_id"], name: "index_categories_profile_models_on_profile_model_id"
  end

  create_table "cloth_sizes", force: :cascade do |t|
    t.string   "gender"
    t.string   "usa"
    t.string   "uk"
    t.string   "eur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_es"
  end

  create_table "ethnicities", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_es"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertises", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_es"
  end

  create_table "expertises_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "expertise_id"
    t.index ["expertise_id"], name: "index_expertises_profile_models_on_expertise_id"
    t.index ["profile_model_id"], name: "index_expertises_profile_models_on_profile_model_id"
  end

  create_table "intents", force: :cascade do |t|
    t.integer  "casting_id"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "profile_model_id"
    t.index ["casting_id"], name: "index_intents_on_casting_id"
    t.index ["profile_model_id"], name: "index_intents_on_profile_model_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_es"
  end

  create_table "languages_profile_contractors", id: false, force: :cascade do |t|
    t.integer "language_id"
    t.integer "profile_contractor_id"
    t.index ["language_id"], name: "index_languages_profile_contractors_on_language_id"
    t.index ["profile_contractor_id"], name: "index_languages_profile_contractors_on_profile_contractor_id"
  end

  create_table "languages_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_languages_profile_models_on_language_id"
    t.index ["profile_model_id"], name: "index_languages_profile_models_on_profile_model_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.string   "asociateable_type"
    t.integer  "asociateable_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "readed",            default: false
    t.integer  "template",          default: 0
    t.string   "title"
    t.string   "description"
    t.string   "thirdable_type"
    t.integer  "thirdable_id"
    t.index ["asociateable_type", "asociateable_id"], name: "index_messages_on_asociateable_type_and_asociateable_id"
    t.index ["ownerable_type", "ownerable_id"], name: "index_messages_on_ownerable_type_and_ownerable_id"
    t.index ["thirdable_type", "thirdable_id"], name: "index_messages_on_thirdable_type_and_thirdable_id"
  end

  create_table "modalities", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_es"
  end

  create_table "modalities_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "modality_id"
    t.index ["modality_id"], name: "index_modalities_profile_models_on_modality_id"
    t.index ["profile_model_id"], name: "index_modalities_profile_models_on_profile_model_id"
  end

  create_table "nationalities", force: :cascade do |t|
    t.string   "name_es"
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
    t.string   "func"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["attachable_type", "attachable_id"], name: "index_photos_on_attachable_type_and_attachable_id"
  end

  create_table "profile_contractors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "represent"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.integer  "nationality_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "profile_models", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.decimal  "chest",               precision: 5, scale: 2
    t.decimal  "waist",               precision: 5, scale: 2
    t.decimal  "hips",                precision: 5, scale: 2
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "eyes_color_id"
    t.integer  "current_province_id"
    t.string   "gender"
    t.decimal  "size_shoes",          precision: 4, scale: 2
    t.decimal  "size_cloth",          precision: 4, scale: 2
    t.integer  "nationality_id"
    t.boolean  "reviewed",                                    default: false
    t.date     "birth_date"
    t.integer  "ethnicity_id"
    t.integer  "height"
    t.index ["current_province_id"], name: "index_profile_models_on_current_province_id"
    t.index ["ethnicity_id"], name: "index_profile_models_on_ethnicity_id"
    t.index ["eyes_color_id"], name: "index_profile_models_on_eyes_color_id"
    t.index ["nationality_id"], name: "index_profile_models_on_nationality_id"
  end

  create_table "profile_photographers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.string   "gender"
    t.integer  "nationality_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["nationality_id"], name: "index_profile_photographers_on_nationality_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_es"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "fromable_type"
    t.integer  "fromable_id"
    t.string   "toable_type"
    t.integer  "toable_id"
    t.text     "review_en"
    t.text     "review_es"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["fromable_type", "fromable_id"], name: "index_reviews_on_fromable_type_and_fromable_id"
    t.index ["toable_type", "toable_id"], name: "index_reviews_on_toable_type_and_toable_id"
  end

  create_table "shoe_sizes", force: :cascade do |t|
    t.string   "gender"
    t.string   "usa"
    t.string   "eur"
    t.string   "uk"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studies", force: :cascade do |t|
    t.string   "title"
    t.string   "place"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.index ["ownerable_type", "ownerable_id"], name: "index_studies_on_ownerable_type_and_ownerable_id"
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
