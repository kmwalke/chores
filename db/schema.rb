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

ActiveRecord::Schema.define(version: 2021_01_26_233548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "actions_permissions", id: false, force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "action_id", null: false
    t.index ["action_id"], name: "index_actions_permissions_on_action_id"
    t.index ["permission_id"], name: "index_actions_permissions_on_permission_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "feature_id", null: false
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "role_id", null: false
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "rewards_users", id: false, force: :cascade do |t|
    t.bigint "reward_id"
    t.bigint "user_id"
    t.datetime "created_at"
    t.index ["reward_id"], name: "index_rewards_users_on_reward_id"
    t.index ["user_id"], name: "index_rewards_users_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
  end

  create_table "task_instances", force: :cascade do |t|
    t.integer "task_id", null: false
    t.datetime "completed_at"
    t.date "created_on"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.integer "frequency", null: false
    t.integer "size", null: false
    t.integer "xp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.integer "level", default: 1, null: false
    t.integer "xp", default: 0, null: false
    t.decimal "xp_multiplier", default: "1.0", null: false
    t.integer "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "next_reward_id"
    t.string "time_zone", default: "UTC", null: false
  end

  add_foreign_key "actions_permissions", "actions"
  add_foreign_key "actions_permissions", "permissions"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
end
