require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  def setup
    sign_in users(:teacher1)
  end

  test "should send email to all recipients" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, classroom_id: classrooms(:one), invitation_emails: "student@email.com, student2@gmail.com"
    end

    invite_email = ActionMailer::Base.deliveries.last

    assert_equal ["student@email.com", "student2@gmail.com"], invite_email.to
    assert_redirected_to people_classroom_path(classrooms(:one))
  end

  test "should give error with invalid email formats" do
    post :create, classroom_id: classrooms(:one), invitation_emails: "student@email.com student2@gmail.com"

    assert_equal "Invalid email format", flash[:alert]
    assert_redirected_to people_classroom_path(classrooms(:one))
  end

  test "should give error with no emails" do
    post :create, classroom_id: classrooms(:one), invitation_emails: ""

    assert_equal "Invalid email format", flash[:alert]
    assert_redirected_to people_classroom_path(classrooms(:one))
  end
end
