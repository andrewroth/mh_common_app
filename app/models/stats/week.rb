class Week < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Week
end
