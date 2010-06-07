require File.dirname(__FILE__) + '/../../../test_helper'

class PrcmethodTest < ActiveSupport::TestCase

  def test_find_methods
    setup_prcmethods
    m = ::Prcmethod.find_methods
    assert_equal(::Prcmethod.all.size, m.size)
    assert_equal(m.first, [Factory(:prcmethod_1).prcMethod_desc])
  end

  def test_find_method_id
    setup_prcmethods
    assert_equal(Factory(:prcmethod_3).id, ::Prcmethod.find_method_id(Factory(:prcmethod_3).prcMethod_desc))
    assert_equal(Factory(:prcmethod_4).id, ::Prcmethod.find_method_id(Factory(:prcmethod_4).prcMethod_desc))
    assert_equal(Factory(:prcmethod_10).id, ::Prcmethod.find_method_id(Factory(:prcmethod_10).prcMethod_desc))
  end

  def test_find_method_description
    setup_prcmethods
    assert_equal(Factory(:prcmethod_3).prcMethod_desc, ::Prcmethod.find_method_description(Factory(:prcmethod_3).id))
    assert_equal(Factory(:prcmethod_2).prcMethod_desc, ::Prcmethod.find_method_description(Factory(:prcmethod_2).id))
    assert_equal(Factory(:prcmethod_10).prcMethod_desc, ::Prcmethod.find_method_description(Factory(:prcmethod_10).id))
  end



end

