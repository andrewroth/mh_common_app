require File.dirname(__FILE__) + '/../test_helper'

class CimHrdbStaffTest < ActiveSupport::TestCase

  def test_boolean_is_active
    Factory(:person_1)
    Factory(:user_1)
    c = Factory(:cimhrdbstaff_1)

    assert_equal(true, c.boolean_is_active)

    c.is_active = 0
    c.save

    assert_equal(false, c.boolean_is_active)
  end

  def test_find_person_id
    p = Factory(:person_1)
    Factory(:user_1)
    c = Factory(:cimhrdbstaff_1)

    assert_equal(p.id, ::CimHrdbStaff.find_person_id(c.id))
  end
end
