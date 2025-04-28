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

ActiveRecord::Schema[7.2].define(version: 2025_04_26_064216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "board_tags", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_tags_on_board_id"
    t.index ["tag_id"], name: "index_board_tags_on_tag_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cut_cube_id"
    t.text "question", null: false
    t.text "answer", null: false
    t.text "explanation"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cut_cube_id"], name: "index_boards_on_cut_cube_id"
    t.index ["user_id", "cut_cube_id"], name: "index_boards_on_user_id_and_cut_cube_id"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cut_cube_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cut_cube_id"], name: "index_bookmarks_on_cut_cube_id"
    t.index ["user_id", "cut_cube_id"], name: "index_bookmarks_on_user_id_and_cut_cube_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "cut_cubes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "cookie_id"
    t.string "cut_id"
    t.text "cut_points"
    t.string "glb_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "memo"
    t.string "cut_face_name"
    t.index ["user_id"], name: "index_cut_cubes_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_favorites_on_board_id"
    t.index ["user_id", "board_id"], name: "index_favorites_on_user_id_and_board_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_likes_on_board_id"
    t.index ["user_id", "board_id"], name: "index_likes_on_user_id_and_board_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "board_tags", "boards"
  add_foreign_key "board_tags", "tags"
  add_foreign_key "boards", "cut_cubes"
  add_foreign_key "boards", "users"
  add_foreign_key "bookmarks", "cut_cubes"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "cut_cubes", "users"
  add_foreign_key "favorites", "boards"
  add_foreign_key "favorites", "users"
  add_foreign_key "likes", "boards"
  add_foreign_key "likes", "users"
end
