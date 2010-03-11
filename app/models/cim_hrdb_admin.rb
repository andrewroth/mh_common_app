class CimHrdbAdmin < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbAdmin
  load_mappings
end
