require File.dirname(__FILE__) + '/../../../../test_helper'

class PersonTest < ActiveSupport::TestCase

  def test_find_person
    p = Factory(:person_1)
    assert_equal(p, ::Person.find_person(p.id))
  end

end

