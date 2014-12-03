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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20141111101841) do

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
=======
ActiveRecord::Schema.define(version: 20141202233630) do

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.string   "text"
>>>>>>> sign-in-out
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
=======
  create_table "photos", force: true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "remote_image_url"
  end
>>>>>>> sign-in-out

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.integer  "posts_id"
    t.string   "posts_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
