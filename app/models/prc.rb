class Prc < ActiveRecord::Base
  include Legacy::Stats::Prc
  load_mappings
end
