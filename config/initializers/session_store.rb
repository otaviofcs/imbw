# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_imbw_the_blog_session',
  :secret      => '8ab04731a081cc4196db6b0f519ce07e21d64b82fc978bf524cf3d14c784a1b5665eb0b94ea27820bc31d2cac4f2599b4f85ba52ecf6e3766141c264ffcb64ac'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
