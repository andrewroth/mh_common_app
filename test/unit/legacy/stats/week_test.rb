require File.dirname(__FILE__) + '/../../../test_helper'

class WeekTest < ActiveSupport::TestCase

  def test_find_stats_staff
    setup_weeks
    setup_weeklyreports

    ::WeeklyReport.find_stats_staff(1, 2, , 1)
  end

end

