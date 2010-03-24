require File.dirname(__FILE__) + '/../../../../test_helper'

class CountryTest < ActiveSupport::TestCase

  def test_find_country_id
    c = Factory(:country_1)
    assert_equal(c.id, ::Country.find_country_id(c.country))
  end

end

