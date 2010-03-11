class CimHrdbPriv < ActiveRecord::Base
  include Legacy::Hrdb::CimHrdbPriv
  load_mappings
end
