Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # 特定のドメインを指定するには、「http://localhost:8080」に変更
      resource '*',
               headers: :any,
               methods: [:get, :post, :put, :delete, :options]
    end
  end
  