Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_CONFIG['FACEBOOK']['APP_ID'], APP_CONFIG['FACEBOOK']['APP_SECRET']
end 