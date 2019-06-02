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

ActiveRecord::Schema.define(version: 2019_06_01_231324) do

  create_table "nweets", force: :cascade do |t|
    t.datetime "did_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "statement", limit: 100
    t.string "url_digest"
    t.index ["url_digest"], name: "index_nweets_on_url_digest", unique: true
    t.index ["user_id", "did_at"], name: "index_nweets_on_user_id_and_did_at"
    t.index ["user_id"], name: "index_nweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "handle_name", limit: 30
    t.string "screen_name", limit: 20
    t.string "icon"
    t.string "url_digest"
    t.string "twitter_uid"
    t.string "twitter_screen_name"
    t.string "twitter_url"
    t.string "twitter_access_secret"
    t.string "twitter_access_token"
    t.boolean "autotweet_enabled", default: false
    t.string "autotweet_content", limit: 40, default: "射精しました！ #nuita [LINK]"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["screen_name"], name: "index_users_on_screen_name", unique: true
    t.index ["url_digest"], name: "index_users_on_url_digest", unique: true
  end

end
