require File.dirname(__FILE__) + '/../../../../test_helper'

class CampusTest < ActiveSupport::TestCase

  def test_find_campus_id
    c = Factory(:campus_1)
    assert_equal(c.id, ::Campus.find_campus_id(c.name))
  end

  def test_find_campus_description
    c = Factory(:campus_1)
    assert_equal(c.name, ::Campus.find_campus_description(c.id))
  end

  def test_find_campus_id_from_short
    c = Factory(:campus_1)
    assert_equal(c.id, ::Campus.find_campus_id_from_short(c.short_desc))
  end

  def test_find_campuses
    Factory(:campus_1)
    Factory(:campus_2)
    Factory(:campus_3)
    Factory(:region_5)
    Factory(:region_6)

    assert_equal([[Factory(:campus_3).desc],[Factory(:campus_2).desc],[Factory(:campus_1).desc]], ::Campus.find_campuses())
  end

  def test_find_campuses_by_region
    Factory(:campus_1)
    Factory(:campus_2)
    Factory(:campus_3)
    Factory(:region_5)

    assert_equal([[Factory(:campus_2).short_desc], [Factory(:campus_1).short_desc]], ::Campus.find_campuses_by_region(5))
  end
end

