Nshvll::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[nshvll.org] ",
  :sender_address => %("NSHVLL Error" <app.error@nshvll.org>),
  :exception_recipients => %w(nshvlltn@gmail.com)