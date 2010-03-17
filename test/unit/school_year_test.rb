require File.dirname(__FILE__) + '/../test_helper'

class SchoolYearTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "description includes level if present" do
    assert_equal("Freshman (1)", Factory(:schoolyear_1).description)
  end
end
