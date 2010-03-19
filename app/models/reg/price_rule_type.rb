class PriceRuleType < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::PriceRuleType
end
