require File.dirname(__FILE__) + '/../test_helper'

class ViewTest < ActiveSupport::TestCase
  def test_build_query_parts_custom_tables
    assert_equal [ 'Access' ], View.new.build_query_parts_custom_tables
  end

  def test_build_query_parts_custom_tables_clause
    View.new.build_query_parts_custom_tables_clause
  end
end
