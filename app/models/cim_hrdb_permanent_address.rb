class CimHrdbPermanentAddress < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbPermanentAddress
  load_mappings
end
