require 'test_helper'

class RequestsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:student1)
    @classroom = classrooms(:two)
    login_as(@student)

    click_link classrooms(:two).name
  end

  test "student can request help and advance the queue" do
    fill_in :request_question, with: "I have a question to add!"
    click_button 'Ask Question'
    assert page.has_content?("I have a question to add!")

    within(all(".request-item").last) { click_link 'Being Helped?' }
    assert all(".request-item").last.has_content?("Being Helped")
    page.document.synchronize do
      within(all(".request-item").last) { click_link 'Done?' }
    end
    assert page.has_no_content?("I have a question to add!")
  end

  test "student can delete their new request" do
    fill_in :request_question, with: "I have a question to delete!"
    click_button 'Ask Question'
    assert page.has_content?("I have a question to delete!")

    within(all(".request-item").last) { click_link 'Delete' }
    assert page.has_no_content?("I have a question to delete!")
  end

  test "student can add themselves to an existing request" do
    @request_id = requests(:two).id
    within("#request#{@request_id}") { click_link 'Me too' }

    assert page.find("#request#{@request_id} .me-too-count").has_content?("+1")
    within("#request#{@request_id}") { click_link 'Me too' }
  end

  teardown do
    log_out
  end
end
