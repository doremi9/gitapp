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

ActiveRecord::Schema.define(version: 20171108130841) do

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.string   "gif_url"
    t.integer  "pull_request_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["pull_request_id"], name: "index_comments_on_pull_request_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar_url"
    t.string   "description"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "pr_id"
    t.integer "number"
    t.string  "state"
    t.string  "title"
    t.string  "body"
    t.integer "repository_id"
    t.string  "author"
    t.index ["repository_id"], name: "index_pull_requests_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
    t.integer  "user_id"
    t.index ["organization_id"], name: "index_repositories_on_organization_id"
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "login"
    t.string   "profile_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
