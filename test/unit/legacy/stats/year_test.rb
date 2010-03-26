require File.dirname(__FILE__) + '/../../../test_helper'

class YearTest < ActiveSupport::TestCase

  def test_find_year_id
    assert_equal(Factory(:year_1).id, ::Year.find_year_id(Factory(:year_1).year_desc))
  end

  def test_find_year_description
    assert_equal(Factory(:year_1).year_desc, ::Year.find_year_description(Factory(:year_1).id))
  end

  def test_find_years
    assert_equal([[Factory(:year_1).year_desc]], ::Year.find_years(Factory(:year_1).id))
    assert_equal([[Factory(:year_1).year_desc], [Factory(:year_2).year_desc]], ::Year.find_years(Factory(:year_2).id))
  end

end

