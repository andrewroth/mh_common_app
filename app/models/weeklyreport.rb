class Weeklyreport < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Weeklyreport
end
