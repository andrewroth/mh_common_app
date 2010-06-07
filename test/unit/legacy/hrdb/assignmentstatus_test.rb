require File.dirname(__FILE__) + '/../../../test_helper'

class AssignmentstatusTest < ActiveSupport::TestCase
  def setup
    setup_assignmentstatuses
  end

  # make sure associations are mapped correctly
  def test_associations
    @assignmentstatus = Assignmentstatus.first
    @assignmentstatus.assignments
  end

  def test_find_status_id
    assert_equal 1, Assignmentstatus.find_status_id("Current Student")
  end
end
