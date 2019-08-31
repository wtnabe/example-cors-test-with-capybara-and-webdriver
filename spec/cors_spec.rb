require 'spec_helper'
require 'pry-byebug'

describe 'CorsSpec' do
  include Capybara::DSL

  def logs
    page.driver.browser.manage.logs.get(:browser)
  end

  let(:cors_blocked_message) { 'has been blocked by CORS' }
  
  describe 'blocked' do
    it {
      visit '/'
      page.driver.evaluate_script('fetch("http://localhost:8000/")')
      sleep 0.2 # log interface is async
      
      assert {
        logs.any? { |log|
          log.message.include?(cors_blocked_message)
        }
      }
    }
  end

  describe 'allowed' do
    it {
      visit '/'
      page.driver.evaluate_script('fetch("http://localhost:8000/public/")')
      sleep 0.2 # log interface is async
      
      assert {
        logs.none? { |log|
          log.message.include?(cors_blocked_message)
        }
      }
    }
  end
end
