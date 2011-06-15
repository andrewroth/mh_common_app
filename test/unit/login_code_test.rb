require File.dirname(__FILE__) + '/../test_helper'

class LoginCodeTest < ActiveSupport::TestCase
  
  def test_acceptable?
    lc = Factory(:login_code_1)
    assert lc
    
    assert_equal lc.acceptable?, true
    
    lc.invalidate
    assert_equal lc.acceptable?, false
    
    lc.acceptable = true
    lc.save!
    assert_equal lc.acceptable?, true
    
    lc.expires_at = 10.minutes.ago
    lc.save!
    assert_equal lc.acceptable?, false
  end
  
  def test_unacceptable?
    lc = Factory(:login_code_1)
    assert lc
    
    assert_equal lc.unacceptable?, false
    
    lc.invalidate
    assert_equal lc.unacceptable?, true
  end
  
  def test_invalidate
    lc = Factory(:login_code_1)
    assert lc
    
    lc.invalidate
    assert_equal lc.acceptable, false
    assert_equal ::LoginCode.first(:conditions => {:id => lc.id}).acceptable, false
  end
  
  def test_increment_times_used
    lc = Factory(:login_code_1)
    assert lc
    
    assert_equal lc.times_used, 0
    lc.increment_times_used
    assert_equal lc.times_used, 1
    lc.increment_times_used
    assert_equal lc.times_used, 2
    lc.increment_times_used
    assert_equal lc.times_used, 3
  end
  
  def test_new_code
    lc = Factory(:login_code_1)
    
    new_code = ::LoginCode.new_code
    
    assert_not_nil new_code
    assert_not_equal new_code, ""
    assert_not_equal new_code, lc.code
    assert new_code.length > 8 # 8 was picked arbitrarily...
  end
  
end
