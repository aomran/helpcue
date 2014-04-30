class InvitationMailer < ActionMailer::Base
  default from: "hello@helpcue.com"

  def invite(emails, classroom_id)
    @classroom = Classroom.find(classroom_id)
    mail to: emails, subject: "You've been invited to a classroom on HelpCue"
  end
end
