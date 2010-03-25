require File.dirname(__FILE__) + '/../../../test_helper'

class CimHrdbAddressTest < ActiveSupport::TestCase

  def test_state=
    a = Factory(:cimhrdbcurrentaddress_1)
    s = Factory(:state_1).abbrev
    a.state = s
    assert_equal(s, a.state)
  end

  def test_country=
    a = Factory(:cimhrdbcurrentaddress_1)
    c = Factory(:country_1).abbrev
    a.country = c
    assert_equal(c, a.country)
  end

  def test_title
    assert_equal(Factory(:title_1).desc, Factory(:cimhrdbcurrentaddress_1).title)
  end

end
