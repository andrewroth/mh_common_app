class Person < ActiveRecord::Base
  load_mappings
  include Common::Core::Person
  include Common::Core::Ca::Person
  include Legacy::Reg::Core::Person
  include Legacy::Stats::Core::Person
end
