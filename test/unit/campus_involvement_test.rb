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

  def test_validate
    Factory(:campusinvolvement_2)
    Factory(:campus_1)
    Factory(:person_3)
    Factory(:schoolyear_1)
    ci = CampusInvolvement.new(:person_id => 2000, :campus_id => 1, :end_date => nil, :ministry_id => 1, :school_year_id => 1)
    ci.validate
    assert_equal("There is already a campus involvement for the campus \"University of California-Davis\"; you can only be involved once per campus.  Archive the existing involvement and try again.", ci.errors["base"])
  end

end
