require_relative '../config/cors'

CorsSpecConfig = lambda {
  Hash[*{
         client: 3000,
         server: 8000
       }.map {|k, v|
         [
           "cors_#{k}_port".to_sym, v,
           "cors_#{k}_uri".to_sym , "http://127.0.0.1:#{v}"
         ]
       }.flatten
      ]
}.call

#
# Server with rack-cors
#
Thread.new {
  Rack::Handler::WEBrick.run(Rack::Builder.new do
                               use Rack::Cors do cors_config end
                               run lambda { |env| [200, {}, []] }
                             end,
                             :Port   => CorsSpecConfig[:cors_server_port],
                             :Logger => WEBrick::BasicLog.new(nil, WEBrick::BasicLog::FATAL)
                            )
  sleep
}

#
# dumb server for running JavaScript
#
Thread.new {
  Rack::Handler::WEBrick.run(
    Rack::Builder.new do
      run lambda { |env| [200, {}, <<EOD.lines] }
<html>
  <head>
    <title>blank page for evaluate JavaScript</title>
  </head>
  <body>
    <h1>blank page for evaluate JavaScript</h1>
  </body>
</html>
EOD
    end,
    :Port => CorsSpecConfig[:cors_client_port],
    :Logger => WEBrick::BasicLog.new(nil, WEBrick::BasicLog::FATAL)
  )
  sleep
}

#
# geckodriver does not support log interface yet
#
Capybara.default_driver = :selenium_chrome
Capybara.register_driver :selenium_chrome do |app|
  Selenium::WebDriver.logger.level = :error
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument 'headless'
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end
Capybara.app_host = CorsSpecConfig[:cors_client_uri]
