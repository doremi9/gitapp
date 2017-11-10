ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'

OmniAuth.config.test_mode = true
  omniauth_hash = { 'provider' => 'github',
                    'uid' => '5911945',
                    'info' => {
                        'login' => 'jedrekdomanski',
                        'image' => 'https://avatars3.githubusercontent.com/u/5911945?v=4'         
                    }
                  }
 
OmniAuth.config.add_mock(:github, omniauth_hash)

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
end