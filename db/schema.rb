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

ActiveRecord::Schema.define(:version => 20110226015931) do

  create_table "disciplines", :force => true do |t|
    t.text     "name"
    t.text     "code"
    t.text     "tpi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "int_monday"
    t.integer  "int_tuesday"
    t.integer  "int_wednesday"
    t.integer  "int_thursday"
    t.integer  "int_friday"
    t.integer  "int_saturday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discipline_id"
  end

end
