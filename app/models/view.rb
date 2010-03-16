class View < ActiveRecord::Base
  load_mappings
  include Pulse::Ca::View
end
