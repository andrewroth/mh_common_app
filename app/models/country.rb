class Country < ActiveRecord::Base
  load_mappings
  include Common::Core::Country
  include Common::Core::Ca::Country
  include Legacy::Reg::Core::Country
  include Legacy::Stats::Core::Country
end
