class Person < ActiveRecord::Base
  load_mappings
  include Common::Core::Person
end
