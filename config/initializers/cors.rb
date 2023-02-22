Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3001', /https*:\/\/.*?herokuapp\.com(?::\d{1,5})?)/, /https*:\/\/.*?ngrok\.io/
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :destroy, :options], expose: ['Authorization']
  end
end