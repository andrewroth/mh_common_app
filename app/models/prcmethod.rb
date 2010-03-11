class Prcmethod < ActiveRecord::Base
  include Legacy::Stats::Prcmethod
  load_mappings
end
