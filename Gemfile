# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.4"
gem "bootsnap", ">= 1.1.0", require: false
gem "devise"
gem "jbuilder", "~> 2.5"
gem "jwt"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "pundit"
gem "rack-cors"
gem "rails", "~> 5.2.4"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "hirb"
  gem "pry-rails"
  gem "rspec-rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "shoulda-matchers"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
