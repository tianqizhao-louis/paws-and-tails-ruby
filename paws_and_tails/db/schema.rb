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

ActiveRecord::Schema[7.0].define(version: 2022_12_16_174706) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name", null: false
    t.string "animal_type", null: false
    t.string "breed", null: false
    t.decimal "price", null: false
    t.datetime "anticipated_birthday", null: false
    t.bigint "breeder_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_link"
    t.index ["breeder_id"], name: "index_animals_on_breeder_id"
  end

  create_table "breeders", force: :cascade do |t|
    t.string "name", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.string "price_level", null: false
    t.text "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "from_user_id", null: false
    t.bigint "to_user_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_messages_on_from_user_id"
    t.index ["to_user_id"], name: "index_messages_on_to_user_id"
  end

  create_table "user_to_breeders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "breeder_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breeder_id"], name: "index_user_to_breeders_on_breeder_id"
    t.index ["user_id"], name: "index_user_to_breeders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "password_digest", null: false
    t.string "user_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waitlists", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_waitlists_on_animal_id"
    t.index ["user_id"], name: "index_waitlists_on_user_id"
  end

  add_foreign_key "animals", "breeders"
  add_foreign_key "messages", "users", column: "from_user_id"
  add_foreign_key "messages", "users", column: "to_user_id"
  add_foreign_key "user_to_breeders", "breeders"
  add_foreign_key "user_to_breeders", "users"
  add_foreign_key "waitlists", "animals"
  add_foreign_key "waitlists", "users"
end
