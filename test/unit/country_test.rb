require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < ActiveSupport::TestCase

  def test_is_closed
    assert_equal(nil, Factory(:country_1).is_closed)
  end
end
