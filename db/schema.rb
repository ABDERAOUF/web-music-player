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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120415093329) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "sort_name"
    t.date     "year"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "albums", ["artist_id"], :name => "index_albums_on_artist_id"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "sort_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "local_songs", :force => true do |t|
    t.string   "location"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "local_songs", ["song_id"], :name => "index_local_songs_on_song_id"

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.string   "sort_name"
    t.integer  "rating"
    t.string   "src_url"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "track_number"
    t.integer  "play_count"
  end

  add_index "songs", ["album_id"], :name => "index_songs_on_album_id"

end
