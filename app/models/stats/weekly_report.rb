class Weeklyreport < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::WeeklyReport
end
