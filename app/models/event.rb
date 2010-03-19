class Event < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::Event
end
