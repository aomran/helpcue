require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "invite" do
    emails = ["first@email.com", "2nd@email.com"]
    mail = InvitationMailer.invite(emails, classrooms(:one).id)

    assert_equal "You've been invited to a classroom on HelpCue", mail.subject
    assert_equal emails, mail.to
    assert_equal ["hello@helpcue.com"], mail.from
    assert_match classrooms(:one).user_token, mail.body.encoded
    assert_match classrooms(:one).name, mail.body.encoded
  end
end
