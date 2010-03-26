require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = Factory(:user_1)
  end

  def test_authenticate
    u = User.authenticate('josh.starcher@example.com', 'test')
    assert u.is_a?(User)
  end
  
  def test_new_password_validation
    @user.update_attributes(:plain_password => 'blahbas')
    assert_equal(1, @user.errors.size) # no mathing confirmation
    
    @user.update_attributes(:plain_password => 'blah', :password_confirmation => 'blah')
    assert_equal(1, @user.errors.size) # not long enough
    
    @user.update_attributes(:plain_password => 'blahblah', :password_confirmation => 'blahblah')
    assert_equal(0, @user.errors.size) # no errors
  end
  
  def test_user_token_nil
    assert !@user.remember_token?
  end
  
  def test_set_remember_me
    @user.remember_me
    assert @user.remember_token?
  end
  
  def test_forget_me
    test_set_remember_me
    @user.forget_me
    test_user_token_nil
  end
  
  def test_stamp_created_on
    u = User.create(:username => 'frank@uscm.org')
    assert_equal(0, u.errors.size)
    assert_not_nil u.created_at
  end

  def test_to_liquid
    assert_equal(Date.today, Date.strptime(Factory(:user_1).to_liquid["created_at"].to_s))
  end

  def test_find_or_create_from_cas
    atts = {"ssoGuid" => "test_ssoGuid", "firstName" => "test_firstName", "lastName" => "test_lastName"}
    CasReceipt.any_instance.stubs(:extra_attributes).returns(atts)

    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("test_username")

    u = User.find_or_create_from_cas(cast)

    assert_equal("test_username", u.username)
    assert_equal(atts["ssoGuid"], u.guid)
    assert_equal(atts["firstName"], u.person.first_name)
    assert_equal(atts["lastName"], u.person.last_name)


    # test user already exists with guid
    User.new(:username => "test_username_2", :guid => "test_guid_2").save
    atts["ssoGuid"] = "test_guid_2"
    
    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("test_username_2")

    u = User.find_or_create_from_cas(cast)

    assert_equal("test_username_2", u.username)
    assert_equal(atts["ssoGuid"], u.guid)


    # test user already exists but without guid
    User.new(:username => "test_username_3", :guid => "").save
    atts["ssoGuid"] = "test_guid_3"

    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("test_username_3")

    u = User.find_or_create_from_cas(cast)

    assert_equal("test_username_3", u.username)
    assert_equal(atts["ssoGuid"], u.guid)
  end
end

class CasTicket
  def response ; end
end
class CasReceipt
  def extra_attributes ; end
  def user ; end
end
