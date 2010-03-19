class Scholarship < ActiveRecord::Base
  load_mappings
  include Legacy::Reg::Scholarship
end
