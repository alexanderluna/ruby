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

ActiveRecord::Schema.define(version: 20170420064920) do

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.string   "git_link"
    t.integer  "views"
    t.integer  "section_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "code_snippet"
    t.text     "title"
    t.text     "image"
    t.index ["section_id"], name: "index_posts_on_section_id"
    t.index ["user_id", "section_id", "created_at"], name: "index_posts_on_user_id_and_section_id_and_created_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "order"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sections_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
