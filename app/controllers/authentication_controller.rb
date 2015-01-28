class AuthenticationController < ApplicationController
  def create
    puts params
    if params[:provider] == "facebook"
      signin_fb
    end
  end

  def signin_fb
    auth = request.env['omniauth.auth']
    # Request a new 60 day token using the current 2 hour token obtained from fb, why not
    auth.merge!(extend_fb_token(auth['credentials']['token']))
    logger.debug "Auth variable: #{auth.inspect}"

    # Already logged in with this fb account before?
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if (authentication)
      authentication.update_attribute("token", auth['extension']['token'])
      user = authentication.user
    else
      # use email to see if already registered, if not create new user
      user = User.find_or_initialize_by(email: auth['info']['email'].downcase)
      user.apply_omniauth(auth) # builds authentication object for user
    end
    saved_status = user.save(:validate=> false)

    # Add the new token and expiration date to the user's session
    create_or_refresh_fb_session(auth)

    if (saved_status)
      user = authentication ? authentication.user : user
      puts session
      sign_in_and_redirect(:user, user)
    else # could not save unvalidated user... 
      render :json => { :errors => user.errors.messages }
    end
  end

  def connect_fb
    auth = request.env['omniauth.auth']
    # Request a new 60 day token using the current 2 hour token obtained from fb, why not
    auth.merge!(extend_fb_token(auth['credentials']['token']))
    logger.debug "Auth variable: #{auth.inspect}"

    # Already logged in with this fb account before?
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if (authentication)
      authentication.update_attribute("token", auth['extension']['token'])
      current_user.authentications << authentication
    else
      current_user.apply_omniauth(auth) # builds authentication object for user
    end
    saved_status = current_user.save

    # Add the new token and expiration date to the user's session
    create_or_refresh_fb_session(auth)

    render :json => { :success => saved_status }
  end

  def destroy
    puts params
    if params[:provider] == "facebook"
      signout_fb
    end
  end

  def signout_fb
    success = delete_fb_session && sign_out(:user)
    render :json => { :success => success.as_json }
  end

  def create_or_refresh_fb_session(auth_hash_or_extension_hash)
    if auth_hash_or_extension_hash['extension']
      session.merge!({
          "fb_access_token" => auth_hash_or_extension_hash['extension']['token'],
          "fb_expiry" => auth_hash_or_extension_hash['extension']['expiry'].to_i + Time.now.to_i
      })
    elsif auth_hash_or_extension_hash['credentials']
      session.merge!({
          "fb_access_token" => auth_hash_or_extension_hash['credentials']['token'],
          "fb_expiry" => auth_hash_or_extension_hash['credentials']['expires_at']
      })
    end
  end

  def extend_fb_token(token)
    # can be called once a day to extend fb access token
    # if called twice or more in one day, will return the same token

    require "net/https"
    require "uri"

    uri = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{APP_CONFIG['FACEBOOK']['APP_ID']}&client_secret=#{APP_CONFIG['FACEBOOK']['APP_SECRET']}&grant_type=fb_exchange_token&fb_exchange_token="+token)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    matched_response = /access_token=(.+)&expires=(.+)/.match(response.body)
    parsed_response = Hash["extension", Hash["token", matched_response[1], "expiry", matched_response[2]]]
    return parsed_response
  end

  def delete_fb_session
    session.delete("fb_expiry")
    session.delete("fb_access_token")
  end
end