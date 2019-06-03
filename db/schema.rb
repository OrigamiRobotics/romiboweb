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

ActiveRecord::Schema.define(version: 2014_04_24_067000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.string "name"
    t.string "nickname"
    t.text "token"
    t.string "email"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "button_colors", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "value"], name: "index_button_colors_on_name_and_value"
  end

  create_table "buttons", force: :cascade do |t|
    t.string "title", null: false
    t.string "speech_phrase"
    t.float "speech_speed_rate"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "button_color_id"
    t.string "size"
    t.integer "row"
    t.integer "col"
    t.boolean "selected", default: false
    t.bigint "palette_id"
    t.index ["button_color_id"], name: "index_buttons_on_button_color_id"
    t.index ["palette_id"], name: "index_buttons_on_palette_id"
    t.index ["size"], name: "index_buttons_on_size"
    t.index ["user_id"], name: "index_buttons_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "statement"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "user_email"
    t.string "page_uri"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "last_viewed_palettes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "palette_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palette_id"], name: "index_last_viewed_palettes_on_palette_id"
    t.index ["user_id"], name: "index_last_viewed_palettes_on_user_id"
  end

  create_table "lesson_subjects", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_subjects_on_lesson_id"
    t.index ["subject_id"], name: "index_lesson_subjects_on_subject_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "subject"
    t.integer "duration"
    t.text "objectives"
    t.text "materials"
    t.string "no_of_instructors"
    t.string "student_size"
    t.text "preparation"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "palette_buttons", force: :cascade do |t|
    t.bigint "palette_id"
    t.bigint "button_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["button_id"], name: "index_palette_buttons_on_button_id"
    t.index ["palette_id"], name: "index_palette_buttons_on_palette_id"
  end

  create_table "palette_lessons", force: :cascade do |t|
    t.bigint "palette_id"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_palette_lessons_on_lesson_id"
    t.index ["palette_id"], name: "index_palette_lessons_on_palette_id"
  end

  create_table "palette_viewers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "palette_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palette_id"], name: "index_palette_viewers_on_palette_id"
    t.index ["user_id"], name: "index_palette_viewers_on_user_id"
  end

  create_table "palettes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.boolean "system", default: false
    t.integer "last_viewed_button"
    t.boolean "all_buttons_selected", default: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "user_name"
    t.bigint "user_id"
    t.string "avatar"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "recommended_lessons", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_recommended_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_recommended_lessons_on_user_id"
  end

  create_table "recommended_palettes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "palette_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["palette_id"], name: "index_recommended_palettes_on_palette_id"
    t.index ["user_id"], name: "index_recommended_palettes_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "auth_token"
    t.string "provider"
    t.string "uid"
    t.string "twitter_nickname"
    t.string "encryption"
    t.string "encryption_key"
    t.string "encryption_iv"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
