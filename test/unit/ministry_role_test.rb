require File.dirname(__FILE__) + '/../test_helper'

class MinistryRoleTest < ActiveSupport::TestCase

  def setup
    setup_ministry_roles
  end

  def test_comparison
    assert MinistryRole.new(:position => 1) <=> MinistryRole.new(:position => 2)
  end
  
  def test_suprior_role
    assert MinistryRole.new(:position => 1) >= MinistryRole.new(:position => 2)
  end

  def test_human_name
    assert_equal("Ministry role", MinistryRole.human_name)
  end

  def test_default_staff_role
    assert_equal(Factory(:ministryrole_9), MinistryRole.default_staff_role)

    StaffRole.find_by_name(%w(Missionary missionary Staff staff)).destroy
    assert_equal(StaffRole.find(2), MinistryRole.default_staff_role)
  end
end
