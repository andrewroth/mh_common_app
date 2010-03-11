class User < ActiveRecord::Base
  load_mappings
  include Common::Core::User
  include Common::Core::User::Ca::User
end
