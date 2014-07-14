source 'https://rubygems.org'

gem 'rake'
gem 'sinatra', '~> 1.4.5'
gem 'sinatra-activerecord', '~> 2.0.2', require: "sinatra/activerecord"
gem 'activerecord', '~> 4.1.4'
gem 'pg', '~> 0.17.1'

gem 'fpm', '~> 1.1.0', group: :packaging

group :development, :test do
  gem 'rspec', '~> 3.0.0'
end

group :development do
  gem 'tux'
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'rack-test', '~> 0.6.2', require: "rack/test"
  gem 'factory_girl', '~> 4.4.0'
end