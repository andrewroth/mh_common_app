class Gender < ActiveRecord::Base
  include Legacy::Hrdb::Gender
  load_mappings
end
