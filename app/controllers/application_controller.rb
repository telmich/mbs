#require 'rubygems'
#require 'net/ldap'

# I need basic auth, see
# http://kosmaczewski.net/2008/07/07/basic-vs-digest/
#
class ApplicationController < ActionController::Base
   protect_from_forgery
   layout 'application'

   before_filter :authorize
   #before_filter :digest_authenticate, :except => [:index, :show]  
   
   @realm = "Use your nethz credentials"

   def authorize
      puts "Authorize was called"
      success = authenticate_or_request_with_http_basic "test" do |username, password|
         puts "User: " + username
         puts "Pass: " + password
         nethz_auth username, password
      end
   end

    # If authentication succeeds, log the user in.  If not, kick back out a failure
    # message as the response body
#    if success
#      session[:user_id] = @user.id
#    else
#      request_http_digest_authentication(User.realm, "Authentication failed")
#    end
#  end

   def nethz_auth(username, password)
      ldap = Net::LDAP.new
      ldap.auth "cn=#{username},ou=users,ou=nethz,ou=id,ou=auth,o=ethz,c=ch", password

      ldap.host = "ldaps02.ethz.ch"
      ldap.port = "636"
      ldap.encryption :simple_tls

      if ldap.bind
         puts "Auth worked for #{username}"
         ok=true
      else
         puts "Auth failed for #{username}"
         ok=false
      end
    
     return ok
   end 
end
