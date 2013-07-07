class SiteMailer < ActionMailer::Base
  default :from => '"NSHVLL" <no_reply@nshvll.org>'
  default_url_options[:host] = 'nshvll.org'

  def member_activation(member)
    @member = member
    mail :to => member.email, :bcc => ADMIN_EMAIL, :subject => '[nshvll.org] Activate your account'
  end

  def member_activated(member)
    @member = member
    mail :to => ADMIN_EMAIL, :subject => '[nshvll.org] Member listing added!'
  end

  def member_edit(member)
    @member = member
    mail :to => member.email, :subject => '[nshvll.org] Link to edit your listing'
  end
end
