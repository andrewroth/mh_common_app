class Semester < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Semester
end
