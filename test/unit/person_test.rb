require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase
#  Person, CustomValue, TrainingAnswer, 
#  Address, User,
#  Ministry, GroupInvolvement, GroupType, Group


  def setup
    setup_n_campus_involvements(10)
    setup_addresses
    setup_campuses
    setup_ministries
    Factory(:ministrycampus_1)
    Factory(:ministrycampus_2)
    Factory(:ministrycampus_3)
    setup_school_years
    setup_ministry_roles
    setup_users
    setup_people
    setup_n_people(2)
    setup_ministry_involvements
    @josh = Person.find(50000)
    @sue = Person.find(2000)
    @personfirst = Person.find(1)
    @person2 = Person.find(2)    
  end
  
  def test_relationships
    assert_not_nil(@personfirst.campus_involvements)
    assert_not_nil(@personfirst.campuses)
    assert_not_nil(@personfirst.ministries)
  end
  
  def test_human_gender
    p = Person.new(:gender => '1')
    assert_equal p.human_gender, 'Male'
  end
  
  def test_set_gender_blank
    p = Person.new
    p.gender = ''
    assert_equal nil, p.human_gender
  end
  
  def test_initiate_addresses
    p = Person.new
    p.initialize_addresses
    assert_not_nil p.current_address
    assert_not_nil p.permanent_address
    assert_not_nil p.emergency_address
  end
  
  def test_find_exact
    #username match
    assert_equal(@josh, Person.find_exact(@josh, @josh.current_address))
    #email match
    assert_equal(@sue, Person.find_exact(@sue, @sue.current_address))
  end
  
  def test_full_name
    assert_equal('Josh Starcher', @josh.full_name)
  end
  
  def test_male?
    assert(@josh.male?)
    assert_equal(false, @sue.male?)
  end
  
  test "person should be born in the past" do
    person = Person.new
    person.first_name = "Invalid Birth Date Test"

    assert person.valid?
    
    person.birth_date = Date.today + 1.days
    assert !person.valid?
    
    person.birth_date = Date.today - 1.days
    assert person.valid?
  end

  test "his - her" do
    assert_equal('his', @josh.hisher)
    assert_equal('her', @sue.hisher)
  end
  
  test "him - her" do
    assert_equal('him', @josh.himher)
    assert_equal('her', @sue.himher)
  end
  
  test "he - she" do
    assert_equal('he', @josh.heshe)
    assert_equal('she', @sue.heshe)
  end
  
  test "person's role in a ministry" do
    assert_equal(@ministry_role_one, @josh.role(@ministry_yfc))
  end

  test "add_or_update_campus adds a campus" do
    assert_difference('CampusInvolvement.count', 1) do
      @personfirst.add_or_update_campus Campus.last.id, SchoolYear.first.id, Ministry.first.id, Person.last
    end
  end

  test "add_or_update_campus updates a campus" do
    ci = CampusInvolvement.first
    @person = ci.person
    assert_no_difference('CampusInvolvement.count') do
      @person.add_or_update_campus ci.campus, SchoolYear.first.id, Ministry.first.id, Person.last
    end
  end

  test "add_or_update_ministry adds a ministry" do
    @person = Person.find 111 # someone without ministry roles
    assert_difference('MinistryInvolvement.count', 1) do
      @person.add_or_update_ministry Ministry.first(2), MinistryRole.find(2)
    end
  end

  test "add_or_update_ministry updates a campus" do
    mi = MinistryInvolvement.first
    @person = mi.person
    assert_no_difference('MinistryInvolvement.count') do
      @person.add_or_update_ministry mi.ministry, MinistryRole.find(2)
    end
  end

  test "working campuses" do
    Factory(:campusinvolvement_3)
    Factory(:ministry_1)
    wc = Factory(:person_1).working_campuses(Factory(:ministryinvolvement_1))
    assert_equal(wc[0]["id"], Factory(:campus_3).id)
    assert_equal(wc[1]["id"], Factory(:campus_1).id)

    Factory(:campusinvolvement_6)
    wc = Factory(:person_2).working_campuses(Factory(:ministryinvolvement_3))
    assert_equal(wc[0]["id"], Factory(:campus_1).id)
  end

  test "add_or_update_campus different school year" do
    ci = Factory(:person_1).add_or_update_campus(Factory(:campusinvolvement_3).campus_id, Factory(:schoolyear_2).id, Factory(:campusinvolvement_3).ministry_id, Factory(:person_1).id)
    assert_equal(ci.school_year, Factory(:schoolyear_2))
  end

  test "admin?" do
    assert_equal(Factory(:person_1).admin?(Factory(:ministry_1)), true)
  end

  test "campus list" do
    Factory(:campusinvolvement_6)
    c = Factory(:person_2).campus_list(Factory(:ministryinvolvement_3))
    assert_equal(c[0].id, 1)
    assert_equal(c.size, 1)
    
    c = Factory(:person_1).campus_list(Factory(:ministryinvolvement_1))
    assert_equal(c[0].id, 2)
    assert_equal(c[1].id, 3)
    assert_equal(c[2].id, 1)
    assert_equal(c.size, 3)
  end

  test "ministry_tree" do
    puts Factory(:person_1).ministry_tree.inspect
  end

end
