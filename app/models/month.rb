class Month < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Month
end
