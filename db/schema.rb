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

ActiveRecord::Schema[7.1].define(version: 2023_12_17_201524) do
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

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "icon"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "trashed"
    t.boolean "published"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "blockable_type"
    t.bigint "blockable_id"
    t.string "title"
    t.string "description"
    t.integer "section_order", default: 0
    t.string "link_url"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockable_type", "blockable_id"], name: "index_blocks_on_blockable"
    t.index ["section_id"], name: "index_blocks_on_section_id"
  end

  create_table "content_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discords", force: :cascade do |t|
    t.string "server_name"
    t.string "server_url"
    t.string "server_icon"
    t.string "server_description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.integer "discord_type"
    t.string "discordable_type"
    t.bigint "discordable_id"
    t.index ["discordable_type", "discordable_id"], name: "index_discords_on_discordable"
    t.index ["user_id"], name: "index_discords_on_user_id"
  end

  create_table "event_comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_comments_on_event_id"
    t.index ["user_id"], name: "index_event_comments_on_user_id"
  end

  create_table "event_managers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_managers_on_event_id"
    t.index ["user_id"], name: "index_event_managers_on_user_id"
  end

  create_table "event_messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.string "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_messages_on_event_id"
    t.index ["user_id"], name: "index_event_messages_on_user_id"
  end

  create_table "event_participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "event_id"], name: "index_event_participations_on_user_id_and_event_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_datetime"
    t.string "address"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "views_count", default: 0, null: false
    t.string "profile_image"
    t.integer "region_id"
    t.string "city"
    t.boolean "featured", default: false, null: false
    t.float "latitude"
    t.float "longitude"
    t.string "facebook"
    t.string "twitter"
    t.string "tiktok"
    t.string "instagram"
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.datetime "end_datetime"
    t.float "cost"
    t.string "location_name"
    t.string "status"
    t.string "event_type"
    t.string "slug", null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "giveaway_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "giveaway_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giveaway_id"], name: "index_giveaway_users_on_giveaway_id"
    t.index ["user_id", "giveaway_id"], name: "index_giveaway_users_on_user_id_and_giveaway_id", unique: true
    t.index ["user_id"], name: "index_giveaway_users_on_user_id"
  end

  create_table "giveaways", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "winner_id"
    t.bigint "creator_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_giveaways_on_creator_id"
    t.index ["event_id"], name: "index_giveaways_on_event_id"
  end

  create_table "hero_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.string "subject"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "trashed"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", null: false
    t.string "category"
    t.string "slug", null: false
    t.string "meta_description"
    t.string "meta_image"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["title"], name: "index_pages_on_title", unique: true
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "photo_comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "photo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.index ["photo_id"], name: "index_photo_comments_on_photo_id"
    t.index ["user_id"], name: "index_photo_comments_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.string "image_url"
    t.integer "favorites_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags"
    t.boolean "published"
    t.string "title"
    t.boolean "trashed"
    t.integer "action_id"
    t.integer "views"
    t.string "description"
    t.integer "region_id"
  end

  create_table "post_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "region_id"
    t.string "description"
    t.string "category_type"
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.string "slug", null: false
    t.index ["slug"], name: "index_post_categories_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "post_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "published"
    t.integer "views"
    t.boolean "trashed"
    t.integer "action_id"
    t.index ["post_category_id"], name: "index_posts_on_post_category_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "profile_image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.string "slug", null: false
    t.index ["slug"], name: "index_regions_on_slug", unique: true
    t.index ["user_id"], name: "index_regions_on_user_id"
  end

  create_table "regions_users", id: false, force: :cascade do |t|
    t.bigint "region_id", null: false
    t.bigint "user_id", null: false
    t.index ["region_id"], name: "index_regions_users_on_region_id"
    t.index ["user_id"], name: "index_regions_users_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
    t.index ["post_id"], name: "index_replies_on_post_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "sectionable_type"
    t.bigint "sectionable_id"
    t.integer "section_order"
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_sections_on_page_id"
    t.index ["sectionable_type", "sectionable_id"], name: "index_sections_on_sectionable"
  end

  create_table "three_grid_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.bigint "block_id", null: false
    t.string "language", null: false
    t.string "title"
    t.string "description"
    t.string "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_translations_on_block_id"
  end

  create_table "two_by_two_grid_sections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "earned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id", "badge_id"], name: "index_user_badges_on_user_id_and_badge_id", unique: true
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "user_type"
    t.string "discord_id"
    t.string "bio"
    t.integer "karma", default: 0
    t.integer "fame", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image"
    t.string "twitch_id"
    t.string "twitch_channel"
    t.string "discord_channel"
    t.string "location"
    t.string "rsi_account"
    t.datetime "last_login"
    t.string "title"
    t.boolean "newsletter", default: false, null: false
    t.boolean "published"
    t.boolean "trashed"
    t.integer "action_id"
  end

  create_table "video_sections", force: :cascade do |t|
    t.string "title"
    t.string "youtube_link"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "votable_type", null: false
    t.bigint "votable_id", null: false
    t.boolean "upvote", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "votable_type", "votable_id"], name: "index_votes_on_user_and_votable", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "blocks", "sections"
  add_foreign_key "discords", "users"
  add_foreign_key "event_comments", "events"
  add_foreign_key "event_comments", "users"
  add_foreign_key "event_managers", "events"
  add_foreign_key "event_managers", "users"
  add_foreign_key "event_messages", "events"
  add_foreign_key "event_messages", "users"
  add_foreign_key "giveaway_users", "giveaways"
  add_foreign_key "giveaway_users", "users"
  add_foreign_key "giveaways", "events"
  add_foreign_key "giveaways", "users", column: "creator_id"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "pages", "users"
  add_foreign_key "photo_comments", "photos"
  add_foreign_key "photo_comments", "users"
  add_foreign_key "posts", "post_categories"
  add_foreign_key "regions", "users"
  add_foreign_key "replies", "posts"
  add_foreign_key "replies", "users"
  add_foreign_key "sections", "pages"
  add_foreign_key "translations", "blocks"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
  add_foreign_key "votes", "users"
end
