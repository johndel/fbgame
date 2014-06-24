OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "development"
    provider :facebook, 'app_id', 'secret_key',
             scope: "public_profile,user_friends,friends_photos,user_photos"
  else
    provider :facebook, 'app_id', 'secret_key',
             scope: "public_profile,user_friends,friends_photos,user_photos"
  end
end