ActiveRecord::Schema.define(:version => 20100116164800) do
  create_table "people", :force => true do |t|
    t.integer "user_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "middle_name"
    t.string  "preferred_name"
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
    t.integer "old_id"
    t.string  "staff_notes"
    t.string  "updated_by",                    :limit => 11
    t.string  "created_by",                    :limit => 11
    t.string  "url",                           :limit => 2000
    t.integer "primary_campus_involvement_id"
    t.integer "mentor_id"
  end
end
