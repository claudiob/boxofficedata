# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'will_paginate'
require 'gruff'
include GruffHacks

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def call_rake(task, options = {})
    # From http://railscasts.com/episodes/127-rake-in-background
    options[:rails_env] ||= Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "rake #{task} #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
