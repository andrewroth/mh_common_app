class CimHrdbCurrentAddress < ActiveRecord::Base
  load_mappings
  include Legacy::Hrdb::CimHrdbCurrentAddress
end
