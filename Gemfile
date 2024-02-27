source "https://rubygems.org"

ruby "3.2.3"

gem "bcrypt", "~> 3.1"
gem "google-authenticator-rails", "~> 3.3"
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
  gem "letter_opener", "~> 1.9.0"
end

group :test do
  gem "database_cleaner-active_record", "~> 2.1.0"
  gem "shoulda-matchers", "~> 6.1.0"
end
