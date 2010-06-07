require File.dirname(__FILE__) + '/../../../test_helper'

class WeekTest < ActiveSupport::TestCase

  def setup
    setup_weeks
    setup_campuses
    setup_weeklyreports
  end

  def test_find_stats_staff
    assert_equal(2, ::Week.find_stats_staff(1, 2, gos_pres, 1))
    assert_equal(49, ::Week.find_stats_staff(2, 2, sp_conv_std, 2))
    assert_equal(39, ::Week.find_stats_staff(2, 2, hs_pres, 2))
    assert_equal(6, ::Week.find_stats_staff(2, 2, hs_pres, 3))
  end

  def test_find_stats_week
    assert_equal(10, ::Week.find_stats_week(1, 5, gos_pres_std))
    assert_equal(44, ::Week.find_stats_week(2, 5, gos_pres))
    assert_equal(121, ::Week.find_stats_week(2, 6, sp_conv))
    assert_equal(155, ::Week.find_stats_week(2, national_region, sp_conv))
  end

  def test_find_stats_month
    assert_equal(265, ::Week.find_stats_month(1, 5, gos_pres))
    assert_equal(0, ::Week.find_stats_month(2, 6, hs_pres))
    assert_equal(625, ::Week.find_stats_month(2, 5, hs_pres))
    assert_equal(486, ::Week.find_stats_month(1, national_region, gos_pres))
  end

  def test_find_stats_semester
    assert_equal(904, ::Week.find_stats_semester(11, 5, gos_pres))
    assert_equal(221, ::Week.find_stats_semester(11, 6, gos_pres))
    assert_equal(0, ::Week.find_stats_semester(12, 6, hs_pres))
    assert_equal(631, ::Week.find_stats_semester(12, 5, hs_pres))
    assert_equal(231, ::Week.find_stats_semester(12, national_region, sp_conv))
  end

  def test_find_stats_semester_campus
    assert_equal(1256, ::Week.find_stats_semester_campus(11, 1, hs_pres))
    assert_equal(631, ::Week.find_stats_semester_campus(12, 1, hs_pres))
    assert_equal(421, ::Week.find_stats_semester_campus(11, 3, sp_conv_std))
  end

  def test_find_week_id
    assert_equal(11, ::Week.find_week_id('2010-03-20'))
    assert_equal(1, ::Week.find_week_id('2010-01-09'))
    assert_equal(14, ::Week.find_week_id('2010-05-09'))
  end

  def test_find_start_date
    assert_equal('2010-01-09', ::Week.find_start_date(2).to_s)
    assert_equal('2010-01-16', ::Week.find_start_date(3).to_s)
    assert_equal('2010-05-09', ::Week.find_start_date(15).to_s)
  end

  def test_find_end_date
    assert_equal('2010-01-16', ::Week.find_end_date(2).to_s)
    assert_equal('2010-01-23', ::Week.find_end_date(3).to_s)
    assert_equal('2010-05-16', ::Week.find_end_date(15).to_s)
  end

  def test_find_weeks_in_month
    assert_equal([Factory(:week_1), Factory(:week_2), Factory(:week_3), Factory(:week_4)], ::Week.find_weeks_in_month(1))
    assert_equal([Factory(:week_13), Factory(:week_14), Factory(:week_15)], ::Week.find_weeks_in_month(5))
  end

  def test_find_weeks_in_semester
    assert_equal([Factory(:week_1), Factory(:week_2), Factory(:week_3), Factory(:week_4),
                  Factory(:week_5), Factory(:week_6), Factory(:week_7), Factory(:week_8),
                  Factory(:week_9), Factory(:week_10), Factory(:week_11), Factory(:week_12),
                  Factory(:week_13)], ::Week.find_weeks_in_semester(11))
    assert_equal([Factory(:week_14), Factory(:week_15)], ::Week.find_weeks_in_semester(12))
  end

  def test_find_weeks
    assert_equal([[Factory(:week_1).week_endDate],
                  [Factory(:week_2).week_endDate],
                  [Factory(:week_3).week_endDate],
                  [Factory(:week_4).week_endDate],
                  [Factory(:week_5).week_endDate],
                  [Factory(:week_6).week_endDate],
                  [Factory(:week_7).week_endDate],
                  [Factory(:week_8).week_endDate],
                  [Factory(:week_9).week_endDate],
                  [Factory(:week_10).week_endDate],
                  [Factory(:week_11).week_endDate],
                  [Factory(:week_12).week_endDate],
                  [Factory(:week_13).week_endDate],
                  [Factory(:week_14).week_endDate],
                  [Factory(:week_15).week_endDate]], ::Week.find_weeks())
  end

  def test_find_semester_id
    assert_equal(11, ::Week.find_semester_id(3))
    assert_equal(12, ::Week.find_semester_id(14))
  end


end

