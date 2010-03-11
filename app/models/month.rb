class Month < ActiveRecord::Base
  include Legacy::Stats::Month
  load_mappings
end
