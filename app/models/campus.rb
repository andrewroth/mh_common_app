class Campus < ActiveRecord::Base
  include Common::Core::Campus
  include Common::Core::Campus::Ca::Campus
  load_mappings
end
