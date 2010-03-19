class FieldValue < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::FieldValue
end
