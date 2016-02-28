if Rails.env.production?
  Nshvll::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[nshvll] ",
    :sender_address => %("NSHVLL Error" <app.error@nshvll.herokuapp.com>),
    :exception_recipients => %w(nshvlltn@gmail.com)
end
