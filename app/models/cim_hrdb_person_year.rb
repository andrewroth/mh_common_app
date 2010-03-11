class CimHrdbPersonYear < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbPersonYear
  load_mappings
end
