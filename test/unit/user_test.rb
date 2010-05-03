require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = Factory(:user_1)
  end

#  def test_authenticate
#    u = User.authenticate('josh.starcher@example.com', 'test')
#    assert u.is_a?(User)
#  end

  def test_human_is_active
    u = Factory(:user_1)
    assert_equal('no', Factory(:user_1).human_is_active)
    u.is_active = 1
    u.save
    assert_equal('yes', Factory(:user_1).human_is_active)
    u.is_active = 0
    u.save
    assert_equal('no', Factory(:user_1).human_is_active)
  end

  def test_in_access_group
    u = Factory(:user_1)

    Factory(:accountadminvieweraccessgroup_1)
    Factory(:accountadminvieweraccessgroup_2)
    Factory(:accountadminaccessgroup_1)
    Factory(:accountadminaccessgroup_2)

    assert_equal(true, u.in_access_group(1, 36))
    assert_equal(true, u.in_access_group(1))
    assert_equal(true, u.in_access_group(36))
    assert_equal(true, u.in_access_group(1, 240))
    assert_equal(false, u.in_access_group(240))
    assert_equal(false, u.in_access_group(23, 2, 999999, 0))
  end

  def test_search
    Factory(:user_1)
    Factory(:user_2)
    Factory(:user_3)
    Factory(:user_4)
    setup_accountadmin_accountgroups
    assert_equal([Factory(:user_1)], ::User.search("josh", 1, 10))
    assert_equal([Factory(:user_4)], ::User.search("8a4ea810", 1, 10))
    assert_equal(::User.all(:conditions => "viewer_id IN (1, 2, 3)"), ::User.search("@", 1, 10))
    assert_equal(nil, ::User.search(nil, 1, 1))
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

#  def test_set_remember_me
#    @user.remember_me
#    assert @user.remember_token?
#  end
#
#  def test_forget_me
#    test_set_remember_me
#    @user.forget_me
#    test_user_token_nil
#  end

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
    p = Person.new(:first_name => "test_firstname", :last_name => "test_lastname", 
                   :person_legal_fname => '', :person_legal_lname => '')
    p.save
    p.create_user_and_access_only("test_guid_2", "test_username_2")
    atts["ssoGuid"] = "test_guid_2"

    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("test_username_2")

    u = User.find_or_create_from_cas(cast)

    assert_equal("test_username_2", u.username)
    assert_equal(atts["ssoGuid"], u.guid)


    # test user already exists but without guid
    User.new(:username => "test_username_3", :guid => "", :last_login => Date.today).save
    atts["ssoGuid"] = "test_guid_3"

    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("test_username_3")

    u = User.find_or_create_from_cas(cast)

    assert_equal("test_username_3", u.username)
    assert_equal(atts["ssoGuid"], u.guid)
   
    # test rescues the viewer_userID set from receipt.user when receipt.user is too short
    p = Person.last
    atts["ssoGuid"] = "test_guid_2"

    cast = CasTicket.new
    casr = CasReceipt.new
    cast.stubs(:response).returns(casr)
    casr.stubs(:user).returns("short")

    u = User.find_or_create_from_cas(cast)

    assert_equal("short", u.username)
    assert_equal(atts["ssoGuid"], u.guid)
  end

  def test_username=
    @user = Factory(:user_1)
    $test_coverage_override = true
    @user.username = "Bobsyeruncle"
    $test_coverage_override = false
  end

  def test_login_callback
    setup_default_user
    @user = Factory(:user_1)
    @user.login_callback
  end
end

class CasTicket
  def response ; end
end
class CasReceipt
  def extra_attributes ; end
  def user ; end
end
