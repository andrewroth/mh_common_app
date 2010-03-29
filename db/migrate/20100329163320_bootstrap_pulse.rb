class BootstrapPulse < ActiveRecord::Migration
  def self.up
    create_table "views", :force => true do |t|
      t.string   "title"
      t.string   "ministry_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "default_view"
      t.string   "select_clause", :limit => 2000
      t.string   "tables_clause", :limit => 2000
    end
  end

  def self.down
  end
end
