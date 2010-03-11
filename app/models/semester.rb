class Semester < ActiveRecord::Base
  include Legacy::Stats::Semester
  load_mappings
end
