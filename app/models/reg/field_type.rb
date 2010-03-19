class FieldType < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::FieldType
end
