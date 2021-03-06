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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110201074646) do

  create_table "bookings", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "begin"
    t.datetime "end"
    t.integer  "modified_by"
    t.boolean  "existing"
    t.string   "comment"
  end

  create_table "machine_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machine_types", :force => true do |t|
    t.string   "name"
    t.float    "ram_gib"
    t.integer  "cores"
    t.string   "cpu_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "machine_type_id"
    t.integer  "modified_by"
    t.integer  "machine_status_id"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
