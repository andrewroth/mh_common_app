class Assignment < ActiveRecord::Base
  include Legacy::Hrdb::Assignment
  load_mappings
end
