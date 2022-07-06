# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_06_142536) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", force: :cascade do |t|
    t.string "name", default: "Quebert"
    t.datetime "last_qrtine"
    t.integer "total_posts", default: 0
    t.integer "total_clicks", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cronfigs", force: :cascade do |t|
    t.integer "days", default: 0
    t.integer "hours", default: 0
    t.integer "minutes", default: 15
    t.integer "seconds", default: 0
    t.boolean "run_on_start", default: true
    t.bigint "bot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_id"], name: "index_cronfigs_on_bot_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "target", null: false
    t.string "body", null: false
    t.boolean "queued", default: true
    t.integer "clicks", default: 0
    t.integer "responses", default: 0
    t.bigint "bot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_id"], name: "index_posts_on_bot_id"
  end

  add_foreign_key "cronfigs", "bots"
  add_foreign_key "posts", "bots"
end
