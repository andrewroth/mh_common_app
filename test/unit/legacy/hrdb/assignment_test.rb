require File.dirname(__FILE__) + '/../../../test_helper'

class AssignmentTest < ActiveSupport::TestCase
  def setup
    setup_assignments
    setup_assignmentstatuses
    setup_campuses
    setup_people
  end

  # make sure associations are mapped correctly
  def test_associations
    @assignment = Assignment.first
    @assignment.assignmentstatus
    @assignment.status
    @assignment.person
    @assignment.campus
  end

  def test_find_staff_on_campus
    assert_equal [ Assignment.find(1) ], Assignment.find_staff_on_campus(Campus.first)
  end
end
