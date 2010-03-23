# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nshvll_session',
  :secret      => '3d3efa872fe81ffe5ded2e0c4c579fe4d0f6409360a23fb09e948e23d827e76f732a4746d0738ded503bff92c7f8bbf74a2e044659f4ff4875aa67913f6c5154'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
