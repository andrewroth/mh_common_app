class SuperAdmin < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::SuperAdmin
end
