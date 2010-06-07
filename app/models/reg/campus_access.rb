class CampusAccess < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::CampusAccess
end
