require File.dirname(__FILE__) + '/../test_helper'

class CimHrdbCurrentAddressTest < ActiveSupport::TestCase
  def setup
    #setup_assignments
    #setup_assignmentstatuses
    #setup_campuses
    setup_people
    #setup_states
  end

  def test_state
    mailing = CimHrdbCurrentAddress.find(50000).mailing
    assert_equal "#1 Josh Street Local<br />JoshCity Local", mailing
  end

  def test_start_date=
    address = CimHrdbCurrentAddress.find(50000)
    start_date = 2.years.ago.to_date
    address.start_date = start_date
    address.save!
    assert_equal start_date, address.start_date
  end
end
