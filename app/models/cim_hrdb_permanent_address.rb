class CimHrdbPermanentAddress < ActiveRecord::Base
  load_mappings
  include Legacy::Hrdb::CimHrdbPermanentAddress
end
