class AccountadminLanguage < ActiveRecord::Base
  include Legacy::Accountadmin::AccountadminLanguage
  load_mappings
end
