class Prcmethod < ActiveRecord::Base
  load_mappings
  include Legacy::Stats::Prcmethod
end
