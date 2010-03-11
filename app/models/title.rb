class Title < ActiveRecord::Base
  include Legacy::Hrdb::Title
  load_mappings
end
