class CimHrdbStaff < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbStaff
  load_mappings
end
