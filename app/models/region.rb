class Region < ActiveRecord::Base
  include Legacy::Hrdb::Region
  load_mappings
end
