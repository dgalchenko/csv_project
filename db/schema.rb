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

ActiveRecord::Schema[7.0].define(version: 2025_02_28_111040) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "registry_number", null: false
    t.string "name", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_companies_on_city", opclass: :gin_trgm_ops, using: :gin
    t.index ["name"], name: "index_companies_on_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["registry_number"], name: "index_companies_on_registry_number", opclass: :gin_trgm_ops, using: :gin
  end

end
