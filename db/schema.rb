# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_11_084905) do

  create_table "address_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "twitter"
    t.string "instagram"
    t.string "postcode"
    t.string "full_address"
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_address_blocks_on_profile_block_id"
  end

  create_table "authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.json "access_token"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "category", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_block_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "favorite_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorite_block_id"], name: "index_favorite_block_likes_on_favorite_block_id"
    t.index ["user_id"], name: "index_favorite_block_likes_on_user_id"
  end

  create_table "favorite_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "text"
    t.integer "category_id", null: false
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_favorite_blocks_on_profile_block_id"
  end

  create_table "my_favorite_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "manga_anime"
    t.string "game_app"
    t.string "character"
    t.string "entertainer"
    t.string "musician"
    t.string "music"
    t.string "food"
    t.string "animal"
    t.string "sports"
    t.string "book"
    t.string "place"
    t.string "snack"
    t.string "alcohol_drink"
    t.string "restaurants"
    t.string "youtuber"
    t.string "actor"
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_my_favorite_blocks_on_profile_block_id"
  end

  create_table "profile_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profile_blocks_on_user_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "height", null: false
    t.integer "gender", null: false
    t.integer "blood_type", null: false
    t.integer "prefecture_id", null: false
    t.datetime "birthday", null: false
    t.datetime "day_of_joinning", null: false
    t.string "public_uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["public_uid"], name: "index_profiles_on_public_uid", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "question_block_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_block_id"], name: "index_question_block_likes_on_question_block_id"
    t.index ["user_id", "question_block_id"], name: "index_question_block_likes_on_user_id_and_question_block_id", unique: true
    t.index ["user_id"], name: "index_question_block_likes_on_user_id"
  end

  create_table "question_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_question_blocks_on_profile_block_id"
  end

  create_table "question_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content", null: false
    t.string "answer"
    t.bigint "question_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_block_id"], name: "index_question_items_on_question_block_id"
  end

  create_table "ranking_block_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ranking_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ranking_block_id"], name: "index_ranking_block_likes_on_ranking_block_id"
    t.index ["user_id", "ranking_block_id"], name: "index_ranking_block_likes_on_user_id_and_ranking_block_id", unique: true
    t.index ["user_id"], name: "index_ranking_block_likes_on_user_id"
  end

  create_table "ranking_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "first_place", null: false
    t.string "second_place", null: false
    t.string "third_place", null: false
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_ranking_blocks_on_profile_block_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "workspace_id", null: false
    t.string "share_channel_id", null: false
    t.string "domain", null: false
    t.integer "share_right", default: 0, null: false
    t.string "image", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["share_channel_id", "workspace_id"], name: "index_teams_on_share_channel_id_and_workspace_id", unique: true
    t.index ["workspace_id"], name: "index_teams_on_workspace_id", unique: true
  end

  create_table "text_block_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "text_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["text_block_id"], name: "index_text_block_likes_on_text_block_id"
    t.index ["user_id", "text_block_id"], name: "index_text_block_likes_on_user_id_and_text_block_id", unique: true
    t.index ["user_id"], name: "index_text_block_likes_on_user_id"
  end

  create_table "text_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_text_blocks_on_profile_block_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "image", null: false
    t.string "email"
    t.integer "role", default: 1, null: false
    t.integer "question_share_right", default: 0, null: false
    t.integer "ranking_share_right", default: 0, null: false
    t.integer "yes_or_no_share_right", default: 0, null: false
    t.integer "text_share_right", default: 0, null: false
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "team_id", "provider"], name: "index_users_on_email_and_team_id_and_provider", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  create_table "yes_or_no_block_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "yes_or_no_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "yes_or_no_block_id"], name: "index_yes_or_no_block_likes_on_user_id_and_yes_or_no_block_id", unique: true
    t.index ["user_id"], name: "index_yes_or_no_block_likes_on_user_id"
    t.index ["yes_or_no_block_id"], name: "index_yes_or_no_block_likes_on_yes_or_no_block_id"
  end

  create_table "yes_or_no_blocks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "profile_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_block_id"], name: "index_yes_or_no_blocks_on_profile_block_id"
  end

  create_table "yes_or_no_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content", null: false
    t.boolean "answer"
    t.bigint "yes_or_no_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["yes_or_no_block_id"], name: "index_yes_or_no_items_on_yes_or_no_block_id"
  end

  add_foreign_key "address_blocks", "profile_blocks"
  add_foreign_key "authentications", "users"
  add_foreign_key "favorite_block_likes", "favorite_blocks"
  add_foreign_key "favorite_block_likes", "users"
  add_foreign_key "favorite_blocks", "profile_blocks"
  add_foreign_key "my_favorite_blocks", "profile_blocks"
  add_foreign_key "profile_blocks", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "question_block_likes", "question_blocks"
  add_foreign_key "question_block_likes", "users"
  add_foreign_key "question_blocks", "profile_blocks"
  add_foreign_key "question_items", "question_blocks"
  add_foreign_key "ranking_block_likes", "ranking_blocks"
  add_foreign_key "ranking_block_likes", "users"
  add_foreign_key "ranking_blocks", "profile_blocks"
  add_foreign_key "text_block_likes", "text_blocks"
  add_foreign_key "text_block_likes", "users"
  add_foreign_key "text_blocks", "profile_blocks"
  add_foreign_key "users", "teams"
  add_foreign_key "yes_or_no_block_likes", "users"
  add_foreign_key "yes_or_no_block_likes", "yes_or_no_blocks"
  add_foreign_key "yes_or_no_blocks", "profile_blocks"
  add_foreign_key "yes_or_no_items", "yes_or_no_blocks"
end
