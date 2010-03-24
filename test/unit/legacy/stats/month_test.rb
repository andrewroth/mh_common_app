require File.dirname(__FILE__) + '/../../../test_helper'

class MonthTest < ActiveSupport::TestCase

  def test_find_start_date
    m1 = Factory(:month_1)
    m2 = Factory(:month_2)
    m3 = Factory(:month_3)

    assert_equal("2010-1-0", ::Month.find_start_date(m1.id))
    assert_equal("2010-2-0", ::Month.find_start_date(m2.id))
    assert_equal("2010-3-0", ::Month.find_start_date(m3.id))
  end

  def test_find_end_date
    m1 = Factory(:month_1)
    m2 = Factory(:month_2)
    m3 = Factory(:month_3)

    assert_equal("2010-1-31", ::Month.find_end_date(m1.id))
    assert_equal("2010-2-31", ::Month.find_end_date(m2.id))
    assert_equal("2010-3-31", ::Month.find_end_date(m3.id))
  end

  def test_find_year_id
    assert_equal(Factory(:month_1).year_id, ::Month.find_year_id(Factory(:month_1).description))
  end

  def test_find_month_id
    assert_equal(Factory(:month_1).id, ::Month.find_month_id(Factory(:month_1).description))
  end

  def test_find_month_description
    assert_equal(Factory(:month_1).description, ::Month.find_month_description(Factory(:month_1).id))
  end

  def test_find_semester_id
    assert_equal(Factory(:month_1).semester_id, ::Month.find_semester_id(Factory(:month_1).description))
  end

  def test_find_months_by_semester
    assert_equal([Factory(:month_1), Factory(:month_2), Factory(:month_3)], ::Month.find_months_by_semester(Factory(:month_1).semester_id))
  end

  def test_find_months
    assert_equal([[Factory(:month_1).description], [Factory(:month_2).description], [Factory(:month_3).description]], ::Month.find_months(Factory(:month_3).id))
  end
end

