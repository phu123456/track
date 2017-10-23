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

ActiveRecord::Schema.define(version: 20171012140919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "is_calculates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "speed"
    t.text "imei"
    t.date "period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "totalDistance"
    t.integer "isCalculate_id"
  end

  create_table "tires", force: :cascade do |t|
    t.text "brand"
    t.integer "start_distance"
    t.integer "current_distance"
    t.integer "total_distance"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
  end

  create_table "tyres", force: :cascade do |t|
    t.string "brand"
    t.text "serial"
    t.decimal "start_distance"
    t.decimal "total_distance"
    t.string "status"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_tyres_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.text "plate"
    t.text "imei"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "distance"
  end

  add_foreign_key "tyres", "vehicles"
end
