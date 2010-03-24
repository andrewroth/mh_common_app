require File.dirname(__FILE__) + '/../test_helper'

class RegionTest < ActiveSupport::TestCase

  def test_find_regions
    Factory(:country_2)
    setup_regions

    regions = ::Region.find_regions(Factory(:country_2))

    assert_equal(3, regions.size)
    assert_equal([["Ontario & Maritimes"], ["Quebec"], ["Western Canada"]], regions)
  end

  def test_find_region_id
    setup_regions
    assert_equal(2, ::Region.find_region_id("Quebec"))
  end
end
