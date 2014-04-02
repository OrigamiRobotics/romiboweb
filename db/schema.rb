# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140402072613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "name"
    t.string   "nickname"
    t.text     "token"
    t.string   "email"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "button_colors", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "button_colors", ["name", "value"], name: "index_button_colors_on_name_and_value", using: :btree

  create_table "buttons", force: true do |t|
    t.string   "title",                             null: false
    t.string   "speech_phrase"
    t.float    "speech_speed_rate"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "button_color_id"
    t.string   "size"
    t.integer  "row"
    t.integer  "col"
    t.boolean  "selected",          default: false
  end

  add_index "buttons", ["button_color_id"], name: "index_buttons_on_button_color_id", using: :btree
  add_index "buttons", ["size"], name: "index_buttons_on_size", using: :btree
  add_index "buttons", ["user_id"], name: "index_buttons_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "statement"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "user_email"
    t.string   "page_uri"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "last_viewed_palettes", force: true do |t|
    t.integer  "user_id"
    t.integer  "palette_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "last_viewed_palettes", ["palette_id"], name: "index_last_viewed_palettes_on_palette_id", using: :btree
  add_index "last_viewed_palettes", ["user_id"], name: "index_last_viewed_palettes_on_user_id", using: :btree

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.string   "subject"
    t.integer  "duration"
    t.string   "objectives"
    t.string   "materials"
    t.string   "no_of_instructors"
    t.string   "student_size"
    t.string   "preparation"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "palette_buttons", force: true do |t|
    t.integer  "palette_id"
    t.integer  "button_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "palette_buttons", ["button_id"], name: "index_palette_buttons_on_button_id", using: :btree
  add_index "palette_buttons", ["palette_id"], name: "index_palette_buttons_on_palette_id", using: :btree

  create_table "palette_viewers", force: true do |t|
    t.integer  "user_id"
    t.integer  "palette_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "palettes", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.boolean  "system",               default: false
    t.integer  "last_viewed_button"
    t.boolean  "all_buttons_selected", default: false
  end

  create_table "profiles", force: true do |t|
    t.string   "user_name"
    t.integer  "user_id"
    t.string   "avatar"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["slug"], name: "index_profiles_on_slug", unique: true, using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "auth_token"
    t.string   "provider"
    t.string   "uid"
    t.string   "twitter_nickname"
    t.string   "encryption"
    t.string   "encryption_key"
    t.string   "encryption_iv"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
