# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_boxofficemojo_session',
  :secret      => 'b5d355f1ba24a8997c41597a206d7c271fd5f8f1726f48751d4175eb69907f4eb9b7ad386a5d6bdc89ec77b015ce6bbc184fe600ad9a0ccc095410fddde6ca9c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
