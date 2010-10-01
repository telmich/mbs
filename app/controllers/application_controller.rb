require 'rubygems'
require 'net/ldap'

class ApplicationController < ActionController::Base
   protect_from_forgery
   layout 'application'

   before_filter :authorize

   def authorize
      puts "Authorize was called"
   end

   #before_filter :digest_authenticate, :except => [:index, :show]  
   before_filter :digest_authenticate

   def digest_authenticate
      puts "Begin auth"
      success = authenticate_or_request_with_http_digest("MyFancyLogin") do |username|
         puts "User: " + username + "Pass: " + password
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

if $0 == __FILE__
   ldap_bind_test ARGV[0] ARGV[1]
end

end
