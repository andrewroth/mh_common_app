require File.dirname(__FILE__) + '/../test_helper'

class CampusTest < ActiveSupport::TestCase

  def test_short_name
    campus = Factory(:campus_1)
    assert_equal campus.short_name, Factory(:campus_1).short_desc
  end
  
  def test_equality
    campus1 = Factory(:campus_1)
    campus2 = Factory(:campus_2)
    assert campus1 <=> campus2
  end

  def test_to_liquid
    assert_equal({"name" => "University of California-Davis"}, Factory(:campus_1).to_liquid)
  end

  def test_all_assignments
    setup_assignments
    assert_equal Factory(:campus_1).all_assignments, [Factory(:assignment_6), Factory(:assignment_5), Factory(:assignment_1), Factory(:assignment_4)]
  end

end

