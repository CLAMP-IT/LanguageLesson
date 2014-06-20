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

ActiveRecord::Schema.define(version: 20140620201235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "title"
    t.text     "content"
    t.string   "type"
    t.string   "response"
    t.integer  "score"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "content_blocks", force: true do |t|
    t.integer  "row_order"
    t.text     "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_lessons", force: true do |t|
    t.integer  "course_id"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_lessons", ["course_id"], name: "index_course_lessons_on_course_id", using: :btree
  add_index "course_lessons", ["lesson_id"], name: "index_course_lessons_on_lesson_id", using: :btree

  create_table "courses", force: true do |t|
    t.integer  "moodle_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lesson_attempts", force: true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lesson_attempts", ["lesson_id"], name: "index_lesson_attempts_on_lesson_id", using: :btree
  add_index "lesson_attempts", ["user_id"], name: "index_lesson_attempts_on_user_id", using: :btree

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.boolean  "graded",               default: false
    t.boolean  "auto_grading",         default: false
    t.boolean  "hide_previous_answer", default: false
    t.boolean  "submission_limited",   default: false
    t.integer  "submission_limit"
    t.string   "default_correct"
    t.string   "default_incorrect"
    t.integer  "max_score"
    t.string   "language_context"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "page_elements", force: true do |t|
    t.integer  "page_id"
    t.integer  "row_order"
    t.integer  "pageable_id"
    t.string   "pageable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "page_elements", ["page_id"], name: "index_page_elements_on_page_id", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "lesson_id"
    t.string   "title"
    t.integer  "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["lesson_id"], name: "index_pages_on_lesson_id", using: :btree

  create_table "question_attempt_responses", force: true do |t|
    t.integer  "question_attempt_id"
    t.integer  "user_id_id"
    t.text     "note"
    t.string   "mark_start"
    t.string   "mark_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_attempt_responses", ["question_attempt_id"], name: "index_question_attempt_responses_on_question_attempt_id", using: :btree
  add_index "question_attempt_responses", ["user_id_id"], name: "index_question_attempt_responses_on_user_id_id", using: :btree

  create_table "question_attempts", force: true do |t|
    t.integer  "lesson_attempt_id"
    t.integer  "question_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id",           null: false
  end

  add_index "question_attempts", ["lesson_attempt_id"], name: "index_question_attempts_on_lesson_attempt_id", using: :btree
  add_index "question_attempts", ["question_id"], name: "index_question_attempts_on_question_id", using: :btree

  create_table "question_recordings", force: true do |t|
    t.integer  "question_id"
    t.integer  "recording_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "question_recordings", ["question_id"], name: "index_question_recordings_on_question_id", using: :btree
  add_index "question_recordings", ["recording_id"], name: "index_question_recordings_on_recording_id", using: :btree

  create_table "questions", force: true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "row_order"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recordings", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "recordable_id"
    t.string   "recordable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "moodle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
