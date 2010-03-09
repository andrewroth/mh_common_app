require File.dirname(__FILE__) + '/../test_helper'
require 'ruby-debug'

class MinistryTest < ActiveSupport::TestCase

  def setup
    setup_ministries
    setup_ministry_campuses
    setup_campuses
    setup_ministry_roles
    setup_people
    setup_ministry_involvements
    setup_ministry_roles
    setup_ministry_campuses
    @m = Hash[*Ministry.all.collect{|m| [m.id, m]}.flatten]
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

  def test_destroy
    mr1_id = Factory(:ministryrole_1)
    mr2_id = Factory(:ministryrole_2)
    m = Factory(:ministry_1)

    m.destroy

    assert_nil(Ministry.find(:first, :conditions => {:id => 1}))
    assert_nil(MinistryRole.find(:first, :conditions => {:id => mr1_id}))
    assert_nil(MinistryRole.find(:first, :conditions => {:id => mr2_id}))
  end

  def test_to_hash_with_children
    h = Factory(:ministry_1).to_hash_with_children
    
    assert_equal(h["children"][0]["id"], 2)
    assert_equal(h["children"][1]["id"], 6)
    assert_equal(h["children"][0]["children"][0]["id"], 3)
  end

  def test_ancestors
    assert_equal(Factory(:ministry_5).ancestors, [Factory(:ministry_5), Factory(:ministry_4)])
  end

  def test_ancestor_ids
    assert_equal(Factory(:ministry_5).ancestor_ids, [Factory(:ministry_5).id, Factory(:ministry_4).id])
  end

  def test_subministry_campuses
    assert_equal([Factory(:ministrycampus_2)], Factory(:ministry_1).subministry_campuses)
  end

  def test_unique_ministry_campuses
    assert_equal([Factory(:ministrycampus_3), Factory(:ministrycampus_1), Factory(:ministrycampus_2)], Factory(:ministry_1).unique_ministry_campuses)
  end
end
