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

ActiveRecord::Schema.define(version: 2022_02_06_134907) do

  create_table "attendances", force: :cascade do |t|
    t.date "date", null: false
    t.decimal "sdn", null: false
    t.decimal "sdi", null: false
    t.integer "status", null: false
    t.integer "employee_id"
    t.integer "payroll_period_id"
    t.integer "payroll_id"
    t.integer "payroll_detail_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
    t.index ["payroll_detail_id"], name: "index_attendances_on_payroll_detail_id"
    t.index ["payroll_id"], name: "index_attendances_on_payroll_id"
    t.index ["payroll_period_id"], name: "index_attendances_on_payroll_period_id"
  end

  create_table "concepts", force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", limit: 150, null: false
    t.integer "concept_type", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.integer "code", null: false
    t.string "first_name", limit: 50, null: false
    t.string "last_name", limit: 100
    t.string "ssn", limit: 11
    t.string "tax_id", limit: 13
    t.string "payment_period", limit: 1, null: false
    t.string "job", limit: 150
    t.boolean "active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payroll_details", force: :cascade do |t|
    t.decimal "quantity", precision: 5, scale: 2, null: false
    t.integer "concept_type", null: false
    t.decimal "taxed", precision: 18, scale: 2, null: false
    t.decimal "exempt", precision: 18, scale: 2, null: false
    t.decimal "retention", precision: 18, scale: 2, null: false
    t.integer "payroll_id", null: false
    t.integer "concept_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["concept_id"], name: "index_payroll_details_on_concept_id"
    t.index ["payroll_id"], name: "index_payroll_details_on_payroll_id"
  end

  create_table "payroll_periods", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "consecutive", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "payroll_period", limit: 1, null: false
    t.decimal "tax_amount", precision: 18, scale: 2
    t.decimal "ssn_amount", precision: 18, scale: 2
    t.decimal "net_amount", precision: 18, scale: 2
    t.integer "status", default: 0
    t.integer "application_status", default: 0
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payrolls", force: :cascade do |t|
    t.decimal "tax_amount", default: "0.0", null: false
    t.decimal "ssn_amount", default: "0.0", null: false
    t.decimal "net_amount", default: "0.0", null: false
    t.boolean "status", default: true, null: false
    t.integer "employee_id", null: false
    t.integer "payroll_period_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
    t.index ["payroll_period_id"], name: "index_payrolls_on_payroll_period_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.datetime "date", precision: 6, null: false
    t.string "salary_type", null: false
    t.decimal "sdn", precision: 10, scale: 2, null: false
    t.decimal "sdi", precision: 10, scale: 2, null: false
    t.boolean "active", default: true, null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_salaries_on_employee_id"
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "attendances", "payroll_details"
  add_foreign_key "attendances", "payroll_periods"
  add_foreign_key "attendances", "payrolls"
  add_foreign_key "payroll_details", "concepts"
  add_foreign_key "payroll_details", "payrolls"
  add_foreign_key "payrolls", "employees"
  add_foreign_key "payrolls", "payroll_periods"
  add_foreign_key "salaries", "employees"
end
