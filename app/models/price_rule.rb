class PriceRule < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::PriceRule
end
