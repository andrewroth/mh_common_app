class Registration < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::Registration
end
