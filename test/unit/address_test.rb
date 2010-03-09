require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase

  def test_mailing
    a = Factory(:address_1)
    assert_equal "108 E. Burlington Ave.<br />Westmont, WY 60559", a.mailing
    a = Factory(:address_2)
    assert_equal ' ', a.mailing
  end
  
  def test_mailing_one_line
    a = Factory(:address_1)
    assert_equal "108 E. Burlington Ave., Westmont, WY 60559", a.mailing_one_line
  end
  
  def test_address_types
    assert_equal('current', CurrentAddress.create(:person_id => '50000', :email => 'example@example.com').address_type)
    assert_equal('emergency1', EmergencyAddress.create(:person_id => '50000', :email => 'example@example.com').address_type)
    assert_equal('permanent', PermanentAddress.create(:person_id => '50000', :email => 'example@example.com').address_type)
  end

  def test_sanify
    a = Factory(:address_1)
    a.sanify
    assert_equal(a.state, nil)
  end

  def test_to_liquid
    assert_equal({"email" => 'josh.starcher@uscm.org', "phone" => '847-980-1420'}, Factory(:address_1).to_liquid)
  end

  def test_start_date=
    a = Factory(:address_1)
    a.start_date = Date.today
    assert_equal(Date.today, a.start_date)

    a.start_date = "05/05/1995"
    assert_equal(Date.strptime("05/05/1995", (I18n.t 'date.formats.default')), a.start_date)
  end

  def test_end_date=
    a = Factory(:address_1)
    a.end_date = Date.today
    assert_equal(Date.today, a.end_date)

    a.end_date = "05/05/1995"
    assert_equal(Date.strptime("05/05/1995", (I18n.t 'date.formats.default')), a.end_date)
  end
end
