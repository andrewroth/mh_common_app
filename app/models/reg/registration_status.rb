class RegistrationStatus < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::RegistrationStatus
end
