class SiteMailer < ActionMailer::Base
  def member_activation(member)
    @subject = '[nshvll.org] Activate your account'
    @body['member'] = member
    @recipients = member.email
    @from = '"NSHVLL" <no_reply@nshvll.org>'
    @sent_on = Time.now
    @headers["X-SMTPAPI"] = {}
  end
end
