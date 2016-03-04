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

ActiveRecord::Schema.define(version: 20160304182537) do

  create_table "direcciones", force: :cascade do |t|
    t.string   "nombre",     limit: 150, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ideas", force: :cascade do |t|
    t.text     "texto",      limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "personas", force: :cascade do |t|
    t.string   "miba_id",    limit: 255
    t.string   "email",      limit: 100, null: false
    t.string   "nombre",     limit: 250, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "subsecretaria", force: :cascade do |t|
    t.string   "nombre",     limit: 150, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
