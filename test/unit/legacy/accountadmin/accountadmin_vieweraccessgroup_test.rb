require File.dirname(__FILE__) + '/../../../test_helper'

class AccountadminVieweraccessgroupTest < ActiveSupport::TestCase

  def test_find_access_ids
    setup_accountadmin_vieweraccessgroups
    u = Factory(:user_1)

    access_ids = ::AccountadminVieweraccessgroup.find_access_ids(u.id)
    assert_equal(2, access_ids.size)
    assert_equal(Factory(:accountadminaccessgroup_1).id, access_ids.first.accessgroup_id)
    assert_equal(Factory(:accountadminaccessgroup_2).id, access_ids.last.accessgroup_id)
  end

end
