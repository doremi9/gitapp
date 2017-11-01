Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scopes: ['read:org', 'user', 'repo']
  OmniAuth.config.logger = Rails.logger
end