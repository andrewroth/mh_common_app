class State < ActiveRecord::Base
  load_mappings
  include Common::Core::State
  include Common::Core::Ca::State
  include Legacy::Reg::Core::State
end
