class Year < ActiveRecord::Base
  include Legacy::Hrdb::Year
  load_mappings
end
