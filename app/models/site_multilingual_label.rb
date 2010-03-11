class SiteMultilingualLabel < ActiveRecord::Base
  include Legacy::Site::SiteMultilingualLabel
  load_mappings
end
