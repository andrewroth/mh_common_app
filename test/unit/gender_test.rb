require File.dirname(__FILE__) + '/../test_helper'

class GenderTest < ActiveSupport::TestCase

  def test_get_all_genders
    setup_genders

    genders = ::Gender.get_all_genders

    assert_equal(3, genders.size)
  end
end
