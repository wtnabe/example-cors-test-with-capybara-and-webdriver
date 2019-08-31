# CORS test example with Capybara and SeleniumWebDriver

You can test CORS config for rack-cors with two dumb rack apps with threads.

 1. use Rack::CORS with your config and empty app.
 2. run app only return HTML for evaluating script on.

## Notice

 * GeckoDriver does not support log interface ( 2019-09-01 )
 * page.driver.browser.manage.log(:browser) interface is async
