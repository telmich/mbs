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
      ldap = Net::LDAP.new

      # FIXME: only one ldap-server supported!
      ldap.host = "ldaps02.ethz.ch"
      ldap.port = "636"
      ldap.encryption :simple_tls

      # offline hack
      #session[:user_id] = (User.find_by_name 'nicosc').id

      # only authorize, if not already done
      # retry until we get a valid username+password

      # FIXME: does this break, if an attacker provides broken session data?
      unless session[:user_id]
         realm = "Use your nethz credentials"

         success = authenticate_or_request_with_http_basic realm do |username, password|
            ldap.auth "cn=#{username},ou=users,ou=nethz,ou=id,ou=auth,o=ethz,c=ch", password

            # rescue block
            begin
               # user has right credentials
               if ldap.bind
                  # add user to db, if needed
                  @user = ensure_user_is_in_db username

                  # record id in session
                  session[:user_id] = @user.id
               else
                  false
               end

               # catch and stop processing
               rescue
                  render :text => "LDAP exception: " + $!.to_s
                  puts "LDAP exception: " + $!.to_s
                  return
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

end
