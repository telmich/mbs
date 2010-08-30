class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

   before_filter :authorize

   def authorize
      puts "Authorize was called"
   end
end
