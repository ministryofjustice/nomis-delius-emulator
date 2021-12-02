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

ActiveRecord::Schema.define(version: 2021_12_02_090146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "offender_id", null: false
    t.date "homeDetentionCurfewEligibilityDate"
    t.date "paroleEligibilityDate"
    t.date "releaseDate"
    t.date "automaticReleaseDate"
    t.date "conditionalReleaseDate"
    t.date "sentenceStartDate"
    t.date "tariffDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offender_id"], name: "index_bookings_on_offender_id"
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "offender_id", null: false
    t.bigint "from_prison_id"
    t.bigint "to_prison_id"
    t.string "typecode", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date", null: false
    t.string "directionCode", limit: 3
    t.index ["offender_id"], name: "index_movements_on_offender_id"
  end

  create_table "offenders", force: :cascade do |t|
    t.bigint "prison_id", null: false
    t.string "offenderNo", limit: 7, null: false
    t.string "categoryCode"
    t.string "mainOffence"
    t.date "receptionDate"
    t.string "firstName"
    t.string "lastName"
    t.string "imprisonmentStatus"
    t.date "dateOfBirth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "recall_flag", default: false, null: false
    t.bigint "keyworker_id"
    t.string "cellLocation"
    t.boolean "restrictedPatient", default: false
    t.string "dischargedHospitalDescription"
    t.index ["offenderNo"], name: "index_offenders_on_offenderNo", unique: true
    t.index ["prison_id"], name: "index_offenders_on_prison_id"
  end

  create_table "prisons", force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "staffId"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstName"
    t.string "lastName"
    t.string "position"
  end

end
