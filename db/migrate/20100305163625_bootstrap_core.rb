class BootstrapCore < ActiveRecord::Migration
  def self.up
    create_table "addresses", :force => true do |t|
      t.integer "person_id"
      t.string  "address_type"
      t.string  "title"
      t.string  "address1"
      t.string  "address2"
      t.string  "city"
      t.string  "state"
      t.string  "zip"
      t.string  "country"
      t.string  "phone"
      t.string  "alternate_phone"
      t.string  "dorm"
      t.string  "room"
      t.string  "email"
      t.date    "start_date"
      t.date    "end_date"
      t.date    "created_at"
      t.date    "updated_at"
      t.boolean "email_validated"
    end

    add_index "addresses", ["email"], :name => "index_addresses_on_email"
    add_index "addresses", ["person_id"], :name => "index_addresses_on_person_id"

    create_table "campus_involvements", :force => true do |t|
      t.integer "person_id"
      t.integer "campus_id"
      t.date    "start_date"
      t.date    "end_date"
      t.integer "ministry_id"
      t.integer "added_by_id"
      t.date    "graduation_date"
      t.integer "school_year_id"
      t.string  "major"
      t.string  "minor"
      t.date    "last_history_update_date"
    end

    add_index "campus_involvements", ["campus_id"], :name => "index_campus_involvements_on_campus_id"
    add_index "campus_involvements", ["ministry_id"], :name => "index_campus_involvements_on_ministry_id"
    add_index "campus_involvements", ["person_id", "campus_id", "end_date"], :name => "index_campus_involvements_on_p_id_and_c_id_and_end_date", :unique => true
    add_index "campus_involvements", ["person_id"], :name => "index_campus_involvements_on_person_id"

    create_table "campuses", :force => true do |t|
      t.string  "name"
      t.string  "address"
      t.string  "city"
      t.string  "state"
      t.string  "zip"
      t.string  "country"
      t.string  "phone"
      t.string  "fax"
      t.string  "url"
      t.string  "abbrv"
      t.boolean "is_secure"
      t.integer "enrollment"
      t.date    "created_at"
      t.date    "updated_at"
      t.string  "type"
      t.string  "address2"
      t.string  "county"
    end

    add_index "campuses", ["county"], :name => "index_campuses_on_county"
    add_index "campuses", ["name"], :name => "index_campuses_on_name"

    create_table "counties", :force => true do |t|
      t.string "name"
      t.string "state"
    end

    add_index "counties", ["state"], :name => "index_counties_on_state"

    create_table "countries", :force => true do |t|
      t.string  "country"
      t.string  "code"
      t.boolean "is_closed"
      t.string  "iso_code"
      t.boolean "closed",    :default => false
    end

    create_table "dorms", :force => true do |t|
      t.integer "campus_id"
      t.string  "name"
      t.date    "created_at"
    end

    add_index "dorms", ["campus_id"], :name => "index_dorms_on_campus_id"

    create_table "emergs", :primary_key => "emerg_id", :force => true do |t|
      t.integer "person_id"
      t.string  "passport_num"
      t.string  "passport_origin"
      t.string  "passport_expiry"
      t.text    "notes"
      t.text    "meds"
      t.string  "health_coverage_state"
      t.string  "health_number"
      t.string  "medical_plan_number"
      t.string  "medical_plan_carrier"
      t.string  "doctor_name"
      t.string  "doctor_phone"
      t.string  "dentist_name"
      t.string  "dentist_phone"
      t.string  "blood_type"
      t.string  "blood_rh_factor"
      t.string  "health_coverage_country"
    end

    create_table "involvement_histories", :force => true do |t|
      t.string   "type"
      t.integer  "person_id"
      t.date     "start_date"
      t.date     "end_date"
      t.integer  "campus_id"
      t.integer  "school_year_id"
      t.integer  "ministry_id"
      t.integer  "ministry_role_id"
      t.integer  "campus_involvement_id"
      t.integer  "ministry_involvement_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "ministries", :force => true do |t|
      t.integer "parent_id"
      t.string  "name"
      t.string  "address"
      t.string  "city"
      t.string  "state"
      t.string  "zip"
      t.string  "country"
      t.string  "phone"
      t.string  "fax"
      t.string  "email"
      t.string  "url"
      t.date    "created_at"
      t.date    "updated_at"
      t.integer "ministries_count"
    end

    add_index "ministries", ["parent_id"], :name => "index_ministries_on_parent_id"

    create_table "ministry_campuses", :force => true do |t|
      t.integer "ministry_id"
      t.integer "campus_id"
    end

    add_index "ministry_campuses", ["ministry_id", "campus_id"], :name => "index_ministry_campuses_on_ministry_id_and_campus_id", :unique => true

    create_table "ministry_involvements", :force => true do |t|
      t.integer "person_id"
      t.integer "ministry_id"
      t.date    "start_date"
      t.date    "end_date"
      t.boolean "admin"
      t.integer "ministry_role_id"
      t.integer "responsible_person_id"
      t.date    "last_history_update_date"
    end

    add_index "ministry_involvements", ["person_id"], :name => "index_ministry_involvements_on_person_id"

    create_table "ministry_role_permissions", :force => true do |t|
      t.integer "permission_id"
      t.integer "ministry_role_id"
      t.string  "created_at"
    end

    create_table "ministry_roles", :force => true do |t|
      t.integer "ministry_id"
      t.string  "name"
      t.date    "created_at"
      t.integer "position"
      t.string  "description"
      t.string  "type"
      t.boolean "involved"
    end

    add_index "ministry_roles", ["ministry_id"], :name => "index_ministry_roles_on_ministry_id"

    create_table "people", :force => true do |t|
      t.integer "user_id"
      t.string  "first_name"
      t.string  "last_name"
      t.string  "middle_name"
      t.string  "preferred_first_name"
      t.string  "gender"
      t.string  "year_in_school"
      t.string  "level_of_school"
      t.date    "graduation_date"
      t.string  "major"
      t.string  "minor"
      t.date    "birth_date"
      t.text    "bio"
      t.string  "image"
      t.date    "created_at"
      t.date    "updated_at"
      t.string  "staff_notes"
      t.integer "updated_by"
      t.integer "created_by"
      t.string  "url",                           :limit => 2000
      t.integer "primary_campus_involvement_id"
      t.integer "mentor_id"
      t.string  "preferred_last_name"
    end

    add_index "people", ["first_name"], :name => "index_people_on_first_name"
    add_index "people", ["last_name", "first_name"], :name => "index_people_on_last_name_and_first_name"
    add_index "people", ["major", "minor"], :name => "index_people_on_major_and_minor"
    add_index "people", ["user_id"], :name => "index_people_on_user_id", :unique => true

    create_table "profile_pictures", :force => true do |t|
      t.integer "person_id"
      t.integer "parent_id"
      t.integer "size"
      t.integer "height"
      t.integer "width"
      t.string  "content_type"
      t.string  "filename"
      t.string  "thumbnail"
      t.date    "uploaded_date"
    end

    create_table "school_years", :force => true do |t|
      t.string   "name"
      t.string   "level"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "states", :force => true do |t|
      t.string   "name"
      t.string   "abbreviation"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "username"
      t.string   "password"
      t.datetime "last_login"
      t.boolean  "system_admin"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "guid"
      t.boolean  "email_validated"
      t.boolean  "developer"
      t.string   "facebook_hash"
      t.string   "facebook_username"
    end

    add_index "users", ["guid"], :name => "index_users_on_guid", :unique => true
  end
end
