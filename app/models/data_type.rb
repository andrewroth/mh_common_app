class DataType < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::DataType
end
