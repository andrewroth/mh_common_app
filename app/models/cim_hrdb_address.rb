class CimHrdbAddress < ActiveRecord::Base
  self.abstract_class = true
  include Legacy::Hrdb::CimHrdbAddress
  load_mappings
end
