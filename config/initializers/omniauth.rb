OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '486935814636-taagm7nb8qn8m52urkblbd0e3llv4f88.apps.googleusercontent.com', 'stQHeCgZJ4yYfZHzdZBuBaea', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
