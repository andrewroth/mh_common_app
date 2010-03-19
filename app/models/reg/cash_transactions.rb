class CashTransaction < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::CashTransaction
end
