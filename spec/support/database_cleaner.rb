RSpec.configure do |config|

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
 
  config.before(:each) do
    DatabaseCleaner.start
  end
 
end