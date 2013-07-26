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

ActiveRecord::Schema.define(:version => 20130726014955) do

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "guest_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "details", :force => true do |t|
    t.string   "description"
    t.datetime "when"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "details_groups", :id => false, :force => true do |t|
    t.integer "group_id",  :null => false
    t.integer "detail_id", :null => false
  end

  add_index "details_groups", ["detail_id", "group_id"], :name => "index_details_groups_on_detail_id_and_group_id", :unique => true

  create_table "details_guests", :id => false, :force => true do |t|
    t.integer "guest_id",  :null => false
    t.integer "detail_id", :null => false
  end

  add_index "details_guests", ["detail_id", "guest_id"], :name => "index_details_guests_on_detail_id_and_guest_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_guests", :id => false, :force => true do |t|
    t.integer "guest_id", :null => false
    t.integer "group_id", :null => false
  end

  add_index "groups_guests", ["group_id", "guest_id"], :name => "index_groups_guests_on_group_id_and_guest_id", :unique => true

  create_table "guests", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "rsvp",            :default => "no_reply"
    t.string   "sitekey"
    t.integer  "invitee_id"
    t.boolean  "admin",           :default => false
    t.string   "password_digest"
    t.boolean  "account_flag",    :default => false
    t.string   "rsvp_info"
  end

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.integer  "guest_id"
    t.string   "tag"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

end
