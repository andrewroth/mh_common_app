require File.dirname(__FILE__) + '/../../../test_helper'

class PrcTest < ActiveSupport::TestCase

  def test_human_integrated_believer
    assert_equal('yes', Factory(:prc_1).human_integrated_believer)
  end

  def test_count_by_date
    setup_prcs
    setup_campuses
    assert_equal(2, ::Prc.count_by_date("2010-01-01", "2010-03-01", Factory(:region_5).id))
    assert_equal(1, ::Prc.count_by_date("2009-01-01", "2010-01-01", Factory(:region_5).id))
    assert_equal(3, ::Prc.count_by_date("2009-01-01", "2011-01-01", Factory(:region_5).id))
    assert_equal(1, ::Prc.count_by_date("2009-12-25", "2010-01-02", Factory(:region_5).id))
    assert_equal(6, ::Prc.count_by_date("2009-01-01", "2011-01-01", Factory(:region_4).id))
  end

  def test_count_by_campus
    setup_prcs
    setup_campuses
    assert_equal(3, ::Prc.count_by_campus("2010-01-01", "2010-04-01", Factory(:campus_3).id))
    assert_equal(1, ::Prc.count_by_campus("2009-12-25", "2010-02-25", Factory(:campus_1).id))
  end

  def test_count_by_semester
    setup_prcs
    setup_campuses
    assert_equal(2, ::Prc.count_by_semester(11, Factory(:region_5).id))
    assert_equal(1, ::Prc.count_by_semester(10, Factory(:region_5).id))
    assert_equal(5, ::Prc.count_by_semester(11, Factory(:region_4).id))
  end

  def test_count_by_semester_and_campus
    setup_prcs
    setup_campuses
    assert_equal(1, ::Prc.count_by_semester_and_campus(10, Factory(:campus_1).id))
    assert_equal(3, ::Prc.count_by_semester_and_campus(11, Factory(:campus_3).id))
  end

  def test_submit_decision
    setup_prcs
    ::Prc.submit_decision(12, 1, 10, Date.today, "lots of notes etc.", "the name", "the witness", 1)

    prc = ::Prc.all(:conditions => { :campus_id => 1, :prc_date => Date.today, :prc_notes => "lots of notes etc."})

    assert_equal(1, prc.size)
    prc = prc.first
    assert_equal(prc.semester_id, 12)
    assert_equal(prc.campus_id, 1)
    assert_equal(prc.prcMethod_id, 10)
    assert_equal(prc.prc_date, Date.today)
    assert_equal(prc.prc_notes, "lots of notes etc.")
    assert_equal(prc.prc_firstName, "the name")
    assert_equal(prc.prc_witnessName, "the witness")
    assert_equal(prc.prc_7upCompleted, 1)
  end

  def test_update_decision
    setup_prcs
    ::Prc.update_decision(1, 12, 1, 10, Date.today, "lots of notes etc.", "the name", "the witness", 1)

    prc = ::Prc.find(1)

    assert_equal(prc.semester_id, 12)
    assert_equal(prc.campus_id, 1)
    assert_equal(prc.prcMethod_id, 10)
    assert_equal(prc.prc_date, Date.today)
    assert_equal(prc.prc_notes, "lots of notes etc.")
    assert_equal(prc.prc_firstName, "the name")
    assert_equal(prc.prc_witnessName, "the witness")
    assert_equal(prc.prc_7upCompleted, 1)
  end

  def test_find_by_semester_and_campus
    setup_prcs
    setup_campuses
    assert_equal([Factory(:prc_6)], ::Prc.find_by_semester_and_campus(10, Factory(:campus_1).id))
    assert_equal([Factory(:prc_3), Factory(:prc_4), Factory(:prc_5)], ::Prc.find_by_semester_and_campus(11, Factory(:campus_3).id))
  end

  def test_find_by_id
    setup_prcs
    assert_equal(Factory(:prc_6), ::Prc.find_by_id(6))
    assert_equal(Factory(:prc_3), ::Prc.find_by_id(3))
  end

  def test_delete_by_id
    setup_prcs
    assert_difference('::Prc.all.size', -1) do
      ::Prc.delete_by_id(6)
    end
    assert_raise(ActiveRecord::RecordNotFound){::Prc.find(6)}
  end

end

