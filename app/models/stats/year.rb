class Year < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Year
end
