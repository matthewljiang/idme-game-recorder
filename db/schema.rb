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

ActiveRecord::Schema.define(version: 20130719193743) do

  create_table "games", force: true do |t|
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.integer  "winner_score"
    t.integer  "loser_score"
    t.integer  "challenger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "p1_change",     default: 0
    t.integer  "p2_change",     default: 0
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "elo",        default: 1200
    t.integer  "weight",     default: 50
    t.integer  "elo_change", default: 0
  end

end
