require File.dirname(__FILE__) + '/../test_helper'

class CampusInvolvementTest < ActiveSupport::TestCase

  def setup
    Factory(:ministry_1)
    setup_ministry_roles
  end

  def test_create_ministry_involvement
    Factory(:person_3)
    mi = Factory(:campusinvolvement_2).find_or_create_ministry_involvement

    assert_not_equal(mi.id, nil)
    assert_equal(mi.person_id, Factory(:person_3).id)
    assert_equal(mi.ministry_id, Factory(:campusinvolvement_2).ministry_id)
  end

  def test_find_ministry_involvement_not_student_role
    Factory(:person_1)
    Factory(:ministryinvolvement_1)
    Factory(:ministryinvolvement_2)
    mi = Factory(:campusinvolvement_3).find_or_create_ministry_involvement
    assert_equal(mi.ministry_role_id, 7)
  end

end
