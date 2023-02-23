# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_215_071_534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'accounts', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'client_name'
    t.string 'owner'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.string 'resource_type'
    t.uuid 'resource_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[name resource_type resource_id], name: 'index_roles_on_name_and_resource_type_and_resource_id'
    t.index %w[resource_type resource_id], name: 'index_roles_on_resource'
  end

  create_table 'teams', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'account_id', null: false
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['account_id'], name: 'index_teams_on_account_id'
  end

  create_table 'tracks', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'trackable_id'
    t.string 'trackable_type'
    t.string 'user_id'
    t.string 'user_name'
    t.string 'team_id'
    t.string 'team_name'
    t.datetime 'started_at'
    t.datetime 'ended_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'level_english'
    t.string 'technical_knowledge'
    t.string 'resume_url'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'jti'
    t.uuid 'team_id'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['team_id'], name: 'index_users_on_team_id'
  end

  create_table 'users_roles', id: false, force: :cascade do |t|
    t.uuid 'user_id'
    t.bigint 'role_id'
    t.index ['role_id'], name: 'index_users_roles_on_role_id'
    t.index %w[user_id role_id], name: 'index_users_roles_on_user_id_and_role_id'
    t.index ['user_id'], name: 'index_users_roles_on_user_id'
  end

  create_table 'versions', force: :cascade do |t|
    t.string 'item_type', null: false
    t.bigint 'item_id', null: false
    t.string 'event', null: false
    t.string 'whodunnit'
    t.text 'object'
    t.datetime 'created_at'
    t.index %w[item_type item_id], name: 'index_versions_on_item_type_and_item_id'
  end

  add_foreign_key 'teams', 'accounts'
  add_foreign_key 'users', 'teams'
end
