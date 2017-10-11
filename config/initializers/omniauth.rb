Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '217516381297-pm7jpmp7291mv8sa9j6cvo1qpcfvu2vo.apps.googleusercontent.com', 'Er7wUyViOaXwFPEGAcXkgQo0'
    OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'
end