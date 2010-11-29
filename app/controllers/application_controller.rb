# Needed for ldap
require 'rubygems'
require 'net/ldap'

# I need basic auth, see
# http://kosmaczewski.net/2008/07/07/basic-vs-digest/
#
class ApplicationController < ActionController::Base
   protect_from_forgery
   layout 'application'

   before_filter :authorize

private

   def authorize
      # only authorize, if not already done
      unless session[:user_id]
         realm = "Use your nethz credentials"

         # retry until we get a valid username - FIXME: retry missing!
         success = authenticate_or_request_with_http_basic realm do |username, password|
            @username = username

            if nethz_auth username, password
               # add user to db, if needed
               @user = ensure_user_is_in_db @username

               # record id in session
               session[:user_id] = @user.id
            else
               false
            end
         end
      end
   end

   def ensure_user_is_in_db(username)
      user = User.find_by_name username
      unless user
         user = User.create({ :name => username })
      end
      user
   end

   def nethz_auth(username, password)
      ldap = Net::LDAP.new
      ldap.auth "cn=#{username},ou=users,ou=nethz,ou=id,ou=auth,o=ethz,c=ch", password
      ldap.host = "ldaps02.ethz.ch"
      ldap.port = "636"
      ldap.encryption :simple_tls

      begin
         if ldap.bind
            ok=true
         else
            ok=false
         end

         # FIXME: add real error handling!!!!
         rescue
            # format.html { redirect_to(@booking, :notice => 'Booking successfully created.') }
            # oder eigene html/error seite
            puts "Ignoring LDAP exception: " + $!.to_s
      end
       
     return ok
   end 
end
