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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(version: 20130928100517) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["code"], name: "index_courses_on_code", unique: true

  create_table "documents", force: true do |t|
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "docfile_file_name"
    t.string   "docfile_content_type"
    t.integer  "docfile_file_size"
    t.datetime "docfile_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "salt"
    t.boolean  "admin"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
