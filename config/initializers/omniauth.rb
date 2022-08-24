require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "9c4f0907d3714790a061805fc1301430", "318e8535fa704c37a62573152d9c4152", scope: 'user-follow-read'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
