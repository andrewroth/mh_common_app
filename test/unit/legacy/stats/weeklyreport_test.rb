require File.dirname(__FILE__) + '/../../../test_helper'

class WeeklyReportTest < ActiveSupport::TestCase

  def setup
    setup_weeks
    setup_campuses
    setup_weeklyreports
  end


  def test_find_stats_campus
    assert_equal(217, ::WeeklyReport.find_stats_campus(1, 1, gos_pres))
    assert_equal(631, ::WeeklyReport.find_stats_campus(5, 1, hs_pres))
  end

  def test_find_staff
    assert_equal([4,5,2], ::WeeklyReport.find_staff(11, 2).collect(&:staff_id))
    assert_equal([3,1], ::WeeklyReport.find_staff(12, 1).collect(&:staff_id))
    assert_equal([2], ::WeeklyReport.find_staff(11, 1, 2).collect(&:staff_id))
    assert_equal([], ::WeeklyReport.find_staff(11, 1, 9).collect(&:staff_id))
  end

  def test_check_submitted
    assert_equal(Factory(:weeklyreport_9), ::WeeklyReport.check_submitted(2, 2, 2))
    assert_equal(Factory(:weeklyreport_6), ::WeeklyReport.check_submitted(2, 2, 3))
    assert_equal(nil, ::WeeklyReport.check_submitted(2, 2, 1))
  end

  def test_submit_stats
    ::WeeklyReport.submit_stats(7, 2, 4, 2, 3, 4, 5, 6)
    wr = ::WeeklyReport.all(:conditions => {:week_id => 7, :campus_id => 2, :staff_id => 4})
    assert_equal(1, wr.size)
    wr = wr.first
    assert_equal(2, wr.spiritual_conversations)
    assert_equal(3, wr.spiritual_conversations_student)
    assert_equal(4, wr.gospel_presentations)
    assert_equal(5, wr.gospel_presentations_student)
    assert_equal(6, wr.holyspirit_presentations)

    ::WeeklyReport.submit_stats(7, 2, 4, 12, 13, 14, 15, 16)
    wr = ::WeeklyReport.all(:conditions => {:week_id => 7, :campus_id => 2, :staff_id => 4})
    assert_equal(1, wr.size)
    wr = wr.first
    assert_equal(12, wr.spiritual_conversations)
    assert_equal(13, wr.spiritual_conversations_student)
    assert_equal(14, wr.gospel_presentations)
    assert_equal(15, wr.gospel_presentations_student)
    assert_equal(16, wr.holyspirit_presentations)
  end

end

