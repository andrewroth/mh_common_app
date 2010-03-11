class Week < ActiveRecord::Base
  include Legacy::Stats::Week
  load_mappings
end
