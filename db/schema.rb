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

ActiveRecord::Schema.define(version: 20170308153756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.string   "profileable_type"
    t.integer  "profileable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "identifier"
    t.index ["identifier"], name: "index_albums_on_identifier", using: :btree
    t.index ["profileable_type", "profileable_id"], name: "index_albums_on_profileable_type_and_profileable_id", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "status",                default: 0
    t.integer  "profile_contractor_id"
    t.integer  "profile_model_id"
    t.text     "description_en"
    t.text     "location_en"
    t.datetime "casting_date"
    t.datetime "shooting_date"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description_es"
    t.text     "location_es"
    t.boolean  "is_direct"
    t.string   "payment"
  end

  create_table "casting_reviews", force: :cascade do |t|
    t.integer  "casting_id"
    t.integer  "profile_contractor_id"
    t.boolean  "show_again",            default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["casting_id"], name: "index_casting_reviews_on_casting_id", using: :btree
    t.index ["profile_contractor_id"], name: "index_casting_reviews_on_profile_contractor_id", using: :btree
  end

  create_table "castings", force: :cascade do |t|
    t.string   "title_en"
    t.text     "description_en"
    t.text     "location_en"
    t.datetime "expiration_date"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "status",            default: 0
    t.integer  "access_type",       default: 0
    t.datetime "casting_date"
    t.datetime "shooting_date"
    t.string   "title_es"
    t.text     "description_es"
    t.text     "location_es"
    t.boolean  "is_direct",         default: true
    t.string   "payment_per_model"
    t.index ["ownerable_type", "ownerable_id"], name: "index_castings_on_ownerable_type_and_ownerable_id", using: :btree
  end

  create_table "castings_categories", id: false, force: :cascade do |t|
    t.integer "casting_id"
    t.integer "category_id",      null: false
    t.integer "profile_model_id"
    t.index ["casting_id"], name: "index_castings_categories_on_casting_id", using: :btree
    t.index ["profile_model_id"], name: "index_castings_categories_on_profile_model_id", using: :btree
  end

  create_table "castings_modalities", id: false, force: :cascade do |t|
    t.integer "casting_id"
    t.integer "modality_id"
    t.index ["casting_id"], name: "index_castings_modalities_on_casting_id", using: :btree
    t.index ["modality_id"], name: "index_castings_modalities_on_modality_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_es"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "profile_type"
  end

  create_table "categories_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_profile_models_on_category_id", using: :btree
    t.index ["profile_model_id"], name: "index_categories_profile_models_on_profile_model_id", using: :btree
  end

  create_table "categories_profile_photographers", id: false, force: :cascade do |t|
    t.integer "profile_photographer_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categories_profile_photographers_on_category_id", using: :btree
    t.index ["profile_photographer_id"], name: "index_cat_prof_photographers_on_profile_photographer_id", using: :btree
  end

  create_table "categories_searches", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "search_id"
    t.index ["category_id"], name: "index_categories_searches_on_category_id", using: :btree
    t.index ["search_id"], name: "index_categories_searches_on_search_id", using: :btree
  end

  create_table "charges", force: :cascade do |t|
    t.string   "profileable_type"
    t.integer  "profileable_id"
    t.decimal  "wallet_charge_amount", default: "0.0"
    t.decimal  "card_charge_amount",   default: "0.0"
    t.integer  "on_action",            default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["profileable_type", "profileable_id"], name: "index_charges_on_profileable_type_and_profileable_id", using: :btree
  end

  create_table "chat_messages", force: :cascade do |t|
    t.string   "body"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.string   "fromable_type"
    t.integer  "fromable_id"
    t.integer  "parent_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["fromable_type", "fromable_id"], name: "index_chat_messages_on_fromable_type_and_fromable_id", using: :btree
    t.index ["ownerable_type", "ownerable_id"], name: "index_chat_messages_on_ownerable_type_and_ownerable_id", using: :btree
    t.index ["parent_id"], name: "index_chat_messages_on_parent_id", using: :btree
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

  create_table "coupon_charges", force: :cascade do |t|
    t.integer  "coupon_id"
    t.integer  "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_coupon_charges_on_coupon_id", using: :btree
    t.index ["wallet_id"], name: "index_coupon_charges_on_wallet_id", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.decimal  "amount",     precision: 5, scale: 2, default: "0.0"
    t.string   "code"
    t.integer  "status",                             default: 0
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "ethnicities", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_es"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertises", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name_es"
    t.integer  "profile_type"
  end

  create_table "expertises_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "expertise_id"
    t.index ["expertise_id"], name: "index_expertises_profile_models_on_expertise_id", using: :btree
    t.index ["profile_model_id"], name: "index_expertises_profile_models_on_profile_model_id", using: :btree
  end

  create_table "intents", force: :cascade do |t|
    t.integer  "casting_id"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "profile_model_id"
    t.index ["casting_id"], name: "index_intents_on_casting_id", using: :btree
    t.index ["profile_model_id"], name: "index_intents_on_profile_model_id", using: :btree
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
    t.index ["language_id"], name: "index_languages_profile_contractors_on_language_id", using: :btree
    t.index ["profile_contractor_id"], name: "index_languages_profile_contractors_on_profile_contractor_id", using: :btree
  end

  create_table "languages_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_languages_profile_models_on_language_id", using: :btree
    t.index ["profile_model_id"], name: "index_languages_profile_models_on_profile_model_id", using: :btree
  end

  create_table "languages_profile_photographers", id: false, force: :cascade do |t|
    t.integer "profile_photographer_id"
    t.integer "language_id"
    t.index ["language_id"], name: "index_languages_profile_photographers_on_language_id", using: :btree
    t.index ["profile_photographer_id"], name: "index_lang_prof_photographers_on_profile_photographer_id", using: :btree
  end

  create_table "level_requests", force: :cascade do |t|
    t.string   "requester_type"
    t.integer  "requester_id"
    t.integer  "level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["requester_type", "requester_id"], name: "index_level_requests_on_requester_type_and_requester_id", using: :btree
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
    t.string   "extra_text_field"
    t.index ["asociateable_type", "asociateable_id"], name: "index_messages_on_asociateable_type_and_asociateable_id", using: :btree
    t.index ["ownerable_type", "ownerable_id"], name: "index_messages_on_ownerable_type_and_ownerable_id", using: :btree
    t.index ["thirdable_type", "thirdable_id"], name: "index_messages_on_thirdable_type_and_thirdable_id", using: :btree
  end

  create_table "modalities", force: :cascade do |t|
    t.string   "name_en"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name_es"
    t.integer  "profile_type"
  end

  create_table "modalities_profile_models", id: false, force: :cascade do |t|
    t.integer "profile_model_id"
    t.integer "modality_id"
    t.index ["modality_id"], name: "index_modalities_profile_models_on_modality_id", using: :btree
    t.index ["profile_model_id"], name: "index_modalities_profile_models_on_profile_model_id", using: :btree
  end

  create_table "modalities_profile_photographers", id: false, force: :cascade do |t|
    t.integer "profile_photographer_id"
    t.integer "modality_id"
    t.index ["modality_id"], name: "index_modalities_profile_photographers_on_modality_id", using: :btree
    t.index ["profile_photographer_id"], name: "index_modty_prof_photographers_on_profile_photographer_id", using: :btree
  end

  create_table "modalities_searches", id: false, force: :cascade do |t|
    t.integer "modality_id"
    t.integer "search_id"
    t.index ["modality_id"], name: "index_modalities_searches_on_modality_id", using: :btree
    t.index ["search_id"], name: "index_modalities_searches_on_search_id", using: :btree
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
    t.index ["attachable_type", "attachable_id"], name: "index_photos_on_attachable_type_and_attachable_id", using: :btree
  end

  create_table "plan_charges", force: :cascade do |t|
    t.string   "plan_name"
    t.decimal  "wallet_charge_amount"
    t.integer  "plan_subscription_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["plan_subscription_id"], name: "index_plan_charges_on_plan_subscription_id", using: :btree
  end

  create_table "plan_subscriptions", force: :cascade do |t|
    t.datetime "end_of_term"
    t.datetime "last_charge"
    t.integer  "plan_id"
    t.string   "chargeable_type"
    t.integer  "chargeable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["chargeable_type", "chargeable_id"], name: "index_plan_subscriptions_on_chargeable_type_and_chargeable_id", using: :btree
    t.index ["plan_id"], name: "index_plan_subscriptions_on_plan_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "target",                                                default: 0
    t.integer  "album_professional_max",                                default: 0
    t.integer  "album_polaroid_max",                                    default: 0
    t.integer  "priority",                                              default: 0
    t.integer  "video_max",                                             default: 0
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.integer  "level",                                                 default: 0
    t.integer  "casting_photos_references_max",                         default: 0
    t.decimal  "charge_per_month",              precision: 5, scale: 2, default: "0.0"
  end

  create_table "profile_contractors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "represent"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.integer  "nationality_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "plan_id"
    t.boolean  "is_partner",     default: false
    t.index ["plan_id"], name: "index_profile_contractors_on_plan_id", using: :btree
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
    t.integer  "level",                                       default: 0
    t.boolean  "warnings_state",                              default: false
    t.integer  "warnings_count",                              default: 0
    t.date     "warnings_last_made"
    t.integer  "plan_id"
    t.boolean  "is_partner",                                  default: false
    t.index ["ethnicity_id"], name: "index_profile_models_on_ethnicity_id", using: :btree
    t.index ["nationality_id"], name: "index_profile_models_on_nationality_id", using: :btree
    t.index ["plan_id"], name: "index_profile_models_on_plan_id", using: :btree
  end

  create_table "profile_photographers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_phone"
    t.string   "land_phone"
    t.string   "address"
    t.string   "gender"
    t.integer  "nationality_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "plan_id"
    t.integer  "current_province_id"
    t.boolean  "is_partner",          default: false
    t.boolean  "reviewed",            default: false
    t.boolean  "warnings_state",      default: false
    t.integer  "warnings_count",      default: 0
    t.date     "warnings_last_made"
    t.index ["nationality_id"], name: "index_profile_photographers_on_nationality_id", using: :btree
    t.index ["plan_id"], name: "index_profile_photographers_on_plan_id", using: :btree
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
    t.index ["fromable_type", "fromable_id"], name: "index_reviews_on_fromable_type_and_fromable_id", using: :btree
    t.index ["toable_type", "toable_id"], name: "index_reviews_on_toable_type_and_toable_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.integer  "province_id"
    t.integer  "nationality_id"
    t.integer  "age_from"
    t.integer  "age_to"
    t.string   "gender"
    t.integer  "height_from"
    t.integer  "height_to"
    t.boolean  "new_face"
    t.boolean  "professional_model"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["nationality_id"], name: "index_searches_on_nationality_id", using: :btree
    t.index ["province_id"], name: "index_searches_on_province_id", using: :btree
  end

  create_table "service_charges", force: :cascade do |t|
    t.integer  "service"
    t.integer  "on_action"
    t.string   "chargeable_type"
    t.integer  "chargeable_id"
    t.string   "asociateable_type"
    t.integer  "asociateable_id"
    t.decimal  "wallet_charge_amount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["asociateable_type", "asociateable_id"], name: "index_service_charges_on_asociateable_type_and_asociateable_id", using: :btree
    t.index ["chargeable_type", "chargeable_id"], name: "index_service_charges_on_chargeable_type_and_chargeable_id", using: :btree
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
    t.index ["ownerable_type", "ownerable_id"], name: "index_studies_on_ownerable_type_and_ownerable_id", using: :btree
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["profileable_type", "profileable_id"], name: "index_users_on_profileable_type_and_profileable_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.integer  "votes_number",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "votable_type"
    t.integer  "votable_id"
    t.date     "last_vote_date"
    t.index ["ownerable_type", "ownerable_id"], name: "index_votes_on_ownerable_type_and_ownerable_id", using: :btree
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal  "amount",         precision: 5, scale: 2, default: "0.0"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.integer  "status",                                 default: 0
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["ownerable_type", "ownerable_id"], name: "index_wallets_on_ownerable_type_and_ownerable_id", using: :btree
  end

  add_foreign_key "casting_reviews", "castings"
  add_foreign_key "casting_reviews", "profile_contractors"
  add_foreign_key "castings_categories", "castings"
  add_foreign_key "castings_categories", "profile_models"
  add_foreign_key "castings_modalities", "castings"
  add_foreign_key "castings_modalities", "modalities"
  add_foreign_key "categories_profile_models", "categories"
  add_foreign_key "categories_profile_models", "profile_models"
  add_foreign_key "categories_profile_photographers", "categories"
  add_foreign_key "categories_profile_photographers", "profile_photographers"
  add_foreign_key "categories_searches", "categories"
  add_foreign_key "categories_searches", "searches"
  add_foreign_key "coupon_charges", "coupons"
  add_foreign_key "coupon_charges", "wallets"
  add_foreign_key "expertises_profile_models", "expertises"
  add_foreign_key "expertises_profile_models", "profile_models"
  add_foreign_key "intents", "castings"
  add_foreign_key "intents", "profile_models"
  add_foreign_key "languages_profile_contractors", "languages"
  add_foreign_key "languages_profile_contractors", "profile_contractors"
  add_foreign_key "languages_profile_models", "languages"
  add_foreign_key "languages_profile_models", "profile_models"
  add_foreign_key "languages_profile_photographers", "languages"
  add_foreign_key "languages_profile_photographers", "profile_photographers"
  add_foreign_key "modalities_profile_models", "modalities"
  add_foreign_key "modalities_profile_models", "profile_models"
  add_foreign_key "modalities_profile_photographers", "modalities"
  add_foreign_key "modalities_profile_photographers", "profile_photographers"
  add_foreign_key "modalities_searches", "modalities"
  add_foreign_key "modalities_searches", "searches"
  add_foreign_key "profile_contractors", "plans"
  add_foreign_key "profile_models", "ethnicities"
  add_foreign_key "profile_models", "nationalities"
  add_foreign_key "profile_models", "plans"
  add_foreign_key "profile_photographers", "nationalities"
  add_foreign_key "profile_photographers", "plans"
  add_foreign_key "searches", "nationalities"
  add_foreign_key "searches", "provinces"
end
