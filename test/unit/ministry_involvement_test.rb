require File.dirname(__FILE__) + '/../test_helper'

class MinistryInvolvementTest < ActiveSupport::TestCase

  def test_validate
    Factory(:ministryinvolvement_1)
    Factory(:ministry_1)
    Factory(:ministryrole_1)
    Factory(:person_1)
    mi = MinistryInvolvement.new(:person_id => 50000, :end_date => nil, :ministry_id => 1, :ministry_role_id => 1)
    mi.validate
    assert_equal("There is already a ministry involvement for the ministry \"YFC\"; you can only be involved once per ministry.  Archive the existing involvement and try again.", mi.errors["base"])
  end
end
