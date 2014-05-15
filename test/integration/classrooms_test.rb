require 'test_helper'

class ClassroomsTest < ActionDispatch::IntegrationTest
  before do
    teacher = users(:teacher1)
    login_as(teacher)
    @classroom = classrooms(:one)
  end

  test "a teacher can create a classroom" do
    click_link "Create Classroom"

    fill_in :classroom_name, with: "New classroom name"
    click_button 'Create Classroom'
    wait_for_ajax

    assert page.has_content?('New classroom name')
  end

  test "a teacher can join a classroom using token" do
    token = Classroom.create(name: "New Classroom with token").user_token
    click_link "Join Classroom"

    fill_in :join_token, with: token
    click_button 'Join Classroom'
    wait_for_ajax

    assert page.has_content?('New Classroom with token')
  end
  end
end
