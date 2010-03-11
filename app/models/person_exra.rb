class PersonExtra < ActiveRecord::Base
  load_mappings
  include Common::Core::Person::Ca::PersonExtra
end
