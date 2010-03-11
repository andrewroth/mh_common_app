class Access < ActiveRecord::Base
  include Legacy::Accountadmin::Access
  load_mappings
end
