class Prc < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Prc
end
