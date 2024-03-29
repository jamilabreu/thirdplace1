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

ActiveRecord::Schema.define(version: 20140116220123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "communities", force: true do |t|
    t.string   "name",                         null: false
    t.string   "filter_name"
    t.string   "member_name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "slug",                         null: false
    t.boolean  "verified",     default: false
    t.boolean  "public",       default: false
    t.integer  "parent_id"
    t.integer  "linkedin_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "community_users", force: true do |t|
    t.integer  "community_id",                 null: false
    t.integer  "user_id",                      null: false
    t.boolean  "admin",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_users", ["community_id"], name: "index_community_users_on_community_id", using: :btree
  add_index "community_users", ["user_id"], name: "index_community_users_on_user_id", using: :btree

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

  create_table "posts", force: true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "subcommunities", force: true do |t|
    t.integer  "community_id",    null: false
    t.integer  "subcommunity_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcommunities", ["community_id"], name: "index_subcommunities_on_community_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                            default: "", null: false
    t.string   "encrypted_password",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.integer  "uid",                    limit: 8
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location"
    t.text     "description"
    t.text     "image"
    t.string   "phone"
    t.string   "headline"
    t.string   "industry"
    t.text     "linkedin_url"
    t.text     "linkedin_image"
    t.text     "linkedin_token"
    t.text     "linkedin_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
