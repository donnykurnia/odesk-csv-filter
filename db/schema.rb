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

ActiveRecord::Schema.define(version: 20131010231626) do

  create_table "products", force: true do |t|
    t.string   "kind"
    t.integer  "height"
    t.boolean  "is_emergency_exit"
    t.boolean  "is_openable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_results", force: true do |t|
    t.integer  "search_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_results", ["product_id"], name: "index_search_results_on_product_id", using: :btree
  add_index "search_results", ["search_id"], name: "index_search_results_on_search_id", using: :btree

  create_table "searches", force: true do |t|
    t.string   "field"
    t.string   "pre_condition"
    t.string   "comparison"
    t.string   "value"
    t.string   "connector"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sort_by"
    t.string   "sort_direction"
  end

  add_index "searches", ["parent_id"], name: "index_searches_on_parent_id", using: :btree

  add_foreign_key "searches", "searches", :name => "searches_parent_id_fk", :column => "parent_id", :dependent => :delete

end
