require 'test_helper'

class RequestsFlowTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:student1)
    @classroom = classrooms(:two)
    login_as(@student)

    click_link classrooms(:two).name
  end

  test "a student can add a question" do
    fill_in :request_question, with: "I has a question!"
    click_button 'Ask Question'

    assert page.find('#requests-list').has_content?("I has a question!")
  end

  test "student can mark question as being-helped" do
    fill_in :request_question, with: "I has another question!"
    click_button 'Ask Question'

    request_id = Request.all.last.id
    find("#request#{request_id}").find(".request-toggle").click

    assert find("#request#{request_id}").has_content?("Being Helped")
  end

  test "student can remove request by marking it as done" do
    fill_in :request_question, with: "I has a good question!"
    click_button 'Ask Question'

    request_id = Request.all.last.id
    find("#request#{request_id}").find(".request-toggle").click
    find("#request#{request_id}").find(".request-remove").click

    page.assert_selector("#request#{request_id}", :count => 0)
  end

  test "student can add themselves to a request" do
    request_id = requests(:two).id
    find("#request#{request_id} .request-metoo").click

    assert find("#request#{request_id} .me-too-count").has_content?("+1")
  end

  test "student can delete a request" do
    request_id = requests(:one).id
    find("#request#{request_id}").find(".request-delete").click
    page.driver.browser.switch_to.alert.accept

    page.assert_selector("#request#{request_id}", :count => 0)
  end

  teardown do
    log_out
  end
end
