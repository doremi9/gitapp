source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
gem 'sqlite3'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'therubyracer'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'omniauth-github'
gem 'gritter', '1.2.0'
gem "octokit", "~> 4.0"
gem 'giphy'



group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.6'
  gem 'capybara'
  gem 'webmock', '~> 3.1'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
