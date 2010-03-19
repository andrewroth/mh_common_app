class EventAdmin < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::EventAdmin
end
