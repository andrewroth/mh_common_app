require File.dirname(__FILE__) + '/../../../test_helper'

class SemesterTest < ActiveSupport::TestCase

  def test_find_semesters_by_year
    setup_years
    setup_semesters

    assert_equal([Factory(:semester_10), Factory(:semester_11), Factory(:semester_12)], ::Semester.find_semesters_by_year(Factory(:year_1).id))
    assert_equal([Factory(:semester_13)], ::Semester.find_semesters_by_year(Factory(:year_2).id))
  end

  def test_find_semester_id
    setup_semesters

    assert_equal(Factory(:semester_12).id, ::Semester.find_semester_id(Factory(:semester_12).semester_desc))
  end

  def test_find_semester_description
    setup_semesters

    assert_equal(Factory(:semester_11).semester_desc, ::Semester.find_semester_description(Factory(:semester_11).semester_id))
  end

  def test_find_semesters
    setup_semesters

    assert_equal([[Factory(:semester_10).semester_desc], [Factory(:semester_11).semester_desc], [Factory(:semester_12).semester_desc]], ::Semester.find_semesters(12))
  end

  def test_find_start_date
    setup_semesters

    assert_equal(Factory(:semester_12).semester_startDate, ::Semester.find_start_date(Factory(:semester_12).id))
  end

  def test_find_end_date
    setup_semesters

    assert_equal(Factory(:semester_13).semester_startDate, ::Semester.find_end_date(Factory(:semester_12).id))
  end

  def test_find_semesters_by_year
    setup_semesters

    assert_equal([Factory(:semester_10), Factory(:semester_11), Factory(:semester_12)], ::Semester.find_semesters_by_year(1))
  end

  def test_find_semester_year
    setup_semesters

    assert_equal(Factory(:year_1).id, ::Semester.find_semester_year(Factory(:semester_11).id))
  end

end

