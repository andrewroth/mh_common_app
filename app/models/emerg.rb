class Emerg < ActiveRecord::Base
  include Legacy::Hrdb::Emerg
  load_mappings
end
