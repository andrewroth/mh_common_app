class YearInSchool < ActiveRecord::Base
  include Legacy::Hrdb::YearInSchool
  load_mappings
end
