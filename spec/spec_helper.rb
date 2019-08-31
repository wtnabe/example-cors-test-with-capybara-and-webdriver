require 'minitest/autorun'
require 'minitest-power_assert'
require 'minitest/reporters'
require 'capybara/minitest'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'
require 'rack'
require 'rack/cors'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
