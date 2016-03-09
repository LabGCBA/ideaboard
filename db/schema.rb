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

ActiveRecord::Schema.define(version: 20160309124503) do

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type",      limit: 255
    t.integer  "creator_id",        limit: 4
    t.string   "editor_type",       limit: 255
    t.integer  "editor_id",         limit: 4
    t.integer  "thread_id",         limit: 4,                 null: false
    t.text     "body",              limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   limit: 4,     default: 0
    t.integer  "cached_votes_down", limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", limit: 255, null: false
    t.integer  "subscriber_id",   limit: 4,   null: false
    t.integer  "thread_id",       limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type", limit: 255
    t.integer  "commontable_id",   limit: 4
    t.datetime "closed_at"
    t.string   "closer_type",      limit: 255
    t.integer  "closer_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "direcciones", force: :cascade do |t|
    t.string   "nombre",           limit: 150, null: false
    t.integer  "subsecretaria_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "ideas", force: :cascade do |t|
    t.text     "texto",      limit: 65535, null: false
    t.integer  "persona_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "personas", force: :cascade do |t|
    t.string   "miba_id",      limit: 255
    t.string   "nombre",       limit: 250, null: false
    t.integer  "direccion_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "subsecretarias", force: :cascade do |t|
    t.string   "nombre",     limit: 150, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote",                      default: false, null: false
    t.integer  "voteable_id",   limit: 4,                   null: false
    t.string   "voteable_type", limit: 255,                 null: false
    t.integer  "voter_id",      limit: 4
    t.string   "voter_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
