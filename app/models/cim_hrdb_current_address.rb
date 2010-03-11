class CimHrdbCurrentAddress < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbCurrentAddress
  load_mappings
end
