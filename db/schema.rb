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

ActiveRecord::Schema.define(version: 2021_11_09_115144) do

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discord_server_links", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "link", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entry_conditions", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "reviewer_id", null: false
    t.integer "reviewee_id", null: false
    t.float "stars", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "recruit_id"
    t.integer "recruit_comment_id"
    t.integer "message_id"
    t.string "action", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checked"], name: "index_notifications_on_checked"
  end

  create_table "play_forms", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruit_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recruit_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruit_entry_conditions", force: :cascade do |t|
    t.integer "recruit_id", null: false
    t.integer "entry_condition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruit_play_forms", force: :cascade do |t|
    t.integer "recruit_id", null: false
    t.integer "play_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruits", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "image_id"
    t.datetime "start_time", null: false
    t.integer "time_required", null: false
    t.integer "capacity", null: false
    t.text "explanation"
    t.string "discord_server_link", null: false
    t.integer "recruit_status", default: 1, null: false
    t.integer "recruit_comments_count", default: 0, null: false
    t.integer "reserves_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recruit_status"], name: "index_recruits_on_recruit_status"
    t.index ["start_time"], name: "index_recruits_on_start_time"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "following_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["following_id"], name: "index_relationships_on_following_id"
  end

  create_table "reserves", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recruit_id", null: false
    t.integer "reserve_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserve_status"], name: "index_reserves_on_reserve_status"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "icon_image_id"
    t.text "introduction"
    t.integer "user_status", default: 0, null: false
    t.integer "recruits_count", default: 0, null: false
    t.integer "reserves_count", default: 0, null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_status"], name: "index_users_on_user_status"
  end

end
