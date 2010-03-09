require File.dirname(__FILE__) + '/../test_helper'

class MinistryTest < ActiveSupport::TestCase

  @data_loaded = false
  def load_data
    if !@data_loaded
      @m = [nil, 
            Factory(:ministry_1), 
            Factory(:ministry_2), 
            Factory(:ministry_3), 
            Factory(:ministry_4), 
            Factory(:ministry_5), 
            Factory(:ministry_6), 
            Factory(:ministry_7)]
      Factory(:ministrycampus_1)
      Factory(:ministrycampus_2)
      Factory(:ministrycampus_3)
      Factory(:campus_1)
      Factory(:campus_2)
      Factory(:campus_3)
      @data_loaded = true
    end

    setup_ministry_roles
    setup_people
    setup_ministry_involvements
    setup_ministry_roles
  end

  def setup
    load_data
  end

  def test_unique_campuses
    assert_not_equal 0, @m[1].unique_campuses.length
  end
  
  def test_deleteable?
    assert !@m[4].deleteable? # root
    assert !@m[2].deleteable? # has children
    assert @m[3].deleteable? # deleteable leaf
  end
  
  def test_campus_ids
    assert_equal([1,3,2], @m[1].campus_ids)
  end
  
  def test_descendants
    assert_equal([@m[3]], @m[2].descendants)
  end
  
  def test_root
    assert_equal(@m[1], @m[2].root)
  end
  
  def test_self_plus_descendants
    assert_equal([@m[2], @m[3]], @m[2].self_plus_descendants)
  end

  def test_staff
    assert_equal Ministry.find(1).staff, [ Person.find(50000) ]
  end

  def test_leaders
    assert_equal Ministry.find(1).leaders, [ Person.find(50000) ]
  end

  def test_ministry_roles
    assert_equal Ministry.find(1).ministry_roles, MinistryRole.find_all_by_ministry_id(1)
  end

  def test_staff_roles
    assert_equal Ministry.find(1).staff_roles, StaffRole.find_all_by_ministry_id(1)
  end

  def test_student_roles
    assert_equal Ministry.find(1).student_roles, StudentRole.find_all_by_ministry_id(1)
  end

  def test_other_roles
    assert_equal Ministry.find(1).other_roles, OtherRole.find_all_by_ministry_id(1)
  end
end
