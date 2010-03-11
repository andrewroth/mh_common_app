class Assignmentstatus < ActiveRecord::Base
  include Legacy::Hrdb::Assignmentstatus
  load_mappings
end
