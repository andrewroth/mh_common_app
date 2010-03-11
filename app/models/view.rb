class View < ActiveRecord::Base
  include Pulse::Ca::View
  load_mappings
end
