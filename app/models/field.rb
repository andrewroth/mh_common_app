class Field < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::Field
end
