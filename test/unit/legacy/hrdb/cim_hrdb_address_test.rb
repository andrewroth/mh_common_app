require File.dirname(__FILE__) + '/../../../test_helper'

class CimHrdbAddressTest < ActiveSupport::TestCase

  def setup
    setup_people
    setup_titles
  end

  def test_state=
    #a = Factory(:cimhrdbcurrentaddress_1)
    a = CimHrdbCurrentAddress.first
    s = Factory(:state_1).abbrev
    a.state = s
    assert_equal(s, a.state)
  end

  def test_country=
    a = CimHrdbCurrentAddress.first
    c = Factory(:country_1).abbrev
    a.country = c
    assert_equal(c, a.country)
  end

  def test_title
    assert_equal(Factory(:title_1).desc, CimHrdbCurrentAddress.find(50000).title)
  end

  def test_mailing
    a = CimHrdbCurrentAddress.find(50000)
    assert_equal "#1 Josh Street Local<br />JoshCity Local<br />ZZZZZZ", a.mailing
  end

  def test_start_date=
    a = CimHrdbCurrentAddress.find(50000)
    a.start_date = Date.today
  end
end
