class Person < ActiveRecord::Base
  load_mappings
  include Common::Core::Person
  include Common::Core::Ca::Person
end
