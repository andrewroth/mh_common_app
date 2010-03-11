class AccountadminAccessgroup < ActiveRecord::Base
  include Legacy::Accountadmin::AccountadminAccessgroup
  load_mappings
end
