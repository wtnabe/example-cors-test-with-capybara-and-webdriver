def cors_config(debug = false)
  lambda {
    allow do
      resource '/public/*', headers: :any, methods: :get, debug: debug
      origins  '*'
    end

    allow do
      resource '/api/*', headers: :any, methods: :any
      origins  '127.0.0.1:3000'
    end
  }.call
end
