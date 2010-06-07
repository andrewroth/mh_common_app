require File.dirname(__FILE__) + '/../../../test_helper'

class AccountadminAccessgroupTest < ActiveSupport::TestCase

  def test_get_users
    setup_accountadmin_vieweraccessgroups
    Factory(:user_1)
    Factory(:user_2)
    assert_equal([Factory(:user_1), Factory(:user_2)], Factory(:accountadminaccessgroup_1).get_users(1, 10))
  end
end
