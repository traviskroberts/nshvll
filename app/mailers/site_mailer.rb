class SiteMailer < ActionMailer::Base
  default :from => '"NSHVLL" <no_reply@nshvll.herokuapp.com>'
  default_url_options[:host] = 'nshvll.herokuapp.com'

  def member_activation(member)
    @member = member
    mail :to => member.email, :bcc => ADMIN_EMAIL, :subject => '[nshvll] Activate your account'
  end

  def member_activated(member)
    @member = member
    mail :to => ADMIN_EMAIL, :subject => '[nshvll] Member listing added!'
  end

  def member_edit(member)
    @member = member
    mail :to => member.email, :subject => '[nshvll] Link to edit your listing'
  end
end
