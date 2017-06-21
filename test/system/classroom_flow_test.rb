require 'application_system_test_case'

class ClassroomFlowTest < ApplicationSystemTestCase
  setup do
    @teacher = users(:teacher1)
    @classroom = classrooms(:one)
    login_as(@teacher)
  end

  test "a teacher can create a classroom" do
    click_link "Create Classroom"

    fill_in :classroom_name, with: "New classroom name"
    click_button 'Create Classroom'

    assert page.has_content?('New classroom name')
  end

  test "a teacher can join a classroom using token" do
    click_link "Join Classroom"

    fill_in :join_token, with: classrooms(:three).user_token
    click_button 'Join Classroom'

    assert page.has_content?('New Classroom with token')
  end

  teardown do
    log_out
  end
end
