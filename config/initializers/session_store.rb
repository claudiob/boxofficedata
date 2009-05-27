# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_boxofficemojo_session',
  :secret      => '4b1cc0e77f97c7cbe64900e74650d204c682ee87c050e3f0e9626deb1c42202133eb60d2d4935953922c4caad83cb972b5ba96db62491e37181a9de5e4a47a42'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
