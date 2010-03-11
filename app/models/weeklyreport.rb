class Weeklyreport < ActiveRecord::Base
  include Legacy::Stats::Weeklyreport
  load_mappings
end
