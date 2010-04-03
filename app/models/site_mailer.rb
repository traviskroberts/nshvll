class SiteMailer < ActionMailer::Base
  def member_activation(member)
    set_email_headers(member)
    @subject = '[nshvll.org] Activate your account'
  end
  
  def member_activated(member)
    set_email_headers(member)
    @subject = '[nshvll.org] Member listing added!'
    @recipients = ADMIN_EMAIL
  end
  
  def member_edit(member)
    set_email_headers(member)
    @subject = '[nshvll.org] Link to edit your listing'
  end
  
  private
  def set_email_headers(member)
    @body['member'] = member
    @recipients = member.email
    @from = '"NSHVLL" <no_reply@nshvll.org>'
    @sent_on = Time.now
    @headers["X-SMTPAPI"] = {}
  end
end
