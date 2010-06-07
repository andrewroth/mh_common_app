class Campus < ActiveRecord::Base
  load_mappings
  include Common::Core::Campus
  include Common::Core::Ca::Campus
  include Legacy::Reg::Core::Campus
  include Legacy::Stats::Core::Campus
end
