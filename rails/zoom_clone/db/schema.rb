# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2017_10_01_020336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", id: :serial, force: :cascade do |t|
    t.string "big_ad"
    t.string "banner_ad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "micropost_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["user_id", "micropost_id", "created_at"], name: "index_comments_on_user_id_and_micropost_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "email_stats", id: :serial, force: :cascade do |t|
    t.string "recipient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delivery_counter", default: 0
    t.integer "total_emails", default: 0
  end

  create_table "microposts", id: :serial, force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.boolean "visible", default: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "newsletters", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.text "message"
    t.string "recipient"
    t.boolean "email_send", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscribed_user_id"
    t.integer "micropost_id"
    t.integer "identifier"
    t.string "notice_type"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_notifications_on_micropost_id"
    t.index ["subscribed_user_id"], name: "index_notifications_on_subscribed_user_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "gender"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "send_email", default: true
    t.integer "bounce_count", default: 0
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "statistics", id: :serial, force: :cascade do |t|
    t.integer "user_count"
    t.integer "facebook_count"
    t.integer "twitter_count"
    t.integer "instagram_count"
    t.integer "unsubscribe_user"
    t.integer "unsubscribe_person"
    t.integer "micropost_count"
    t.integer "commment_count"
    t.integer "relationship_count"
    t.integer "like_count"
    t.integer "notification_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "reset_digest"
    t.datetime "reset_send_at"
    t.string "avatar"
    t.string "uid"
    t.string "provider"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean "send_email", default: true
    t.string "country"
    t.string "language"
    t.string "gender"
    t.boolean "banned", default: false
    t.boolean "notify", default: true
    t.integer "bounce_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "votable_id"
    t.string "votable_type"
    t.integer "voter_id"
    t.string "voter_type"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "notifications", "microposts"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "subscribed_user_id"
end
