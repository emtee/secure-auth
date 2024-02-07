source "https://rubygems.org"

ruby "3.2.3"

gem "bcrypt", "~> 3.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem "factory_bot_rails", "~> 6.4.0"
  gem "faker", "~> 3.2.3"
  gem "rspec-rails", "~> 6.1.0"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "database_cleaner-active_record"
  gem "shoulda-matchers", "~> 6.1.0"
end
