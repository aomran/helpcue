require 'application_system_test_case'

class RequestsFlowTest < ApplicationSystemTestCase
  setup do
    @student = users(:student1)
    @classroom = classrooms(:one)
    assert_equal 0, @classroom.requests.count
    login_as(@student)

    click_link @classroom.name
  end

  test "student can request help and advance the queue" do
    add_question "I have a question to add!"

    click_link 'Being Helped?'
    assert page.has_content?("Being Helped")

    click_link 'Done?'
    assert page.has_no_content?("I have a question to add!")
  end

  test "student can delete their new request" do
    add_question "I have a question to delete!"

    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept
    assert page.has_no_content?("I have a question to delete!")
  end

  test "student can add themselves to an existing request" do
    add_question 'Existing question'
    click_link 'Account'
    click_link 'Log Out'

    other_student = users(:student2)
    login_as(other_student)
    click_link @classroom.name

    click_link 'Me too'
    assert page.find(".me-too-count").has_content?("+1")
  end

  teardown do
    log_out
  end

  def add_question(question)
    fill_in :request_question, with: question
    click_button 'Ask Question'
    assert page.has_content?(question)
  end
end
