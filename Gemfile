source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.6.5"
gem "active_storage_validations", "~> 0.8.7"
gem "bcrypt", "~> 3.1.13"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "~> 3.4", ">= 3.4.1"
gem "config", "~> 2.2", ">= 2.2.1"
gem "faker", "~> 2.10", ">= 2.10.2"
gem "figaro", "~> 1.1", ">= 1.1.1"
gem "i18n-js", "~> 3.6"
gem "image_processing", "~> 1.10", ">= 1.10.3"
gem "jbuilder", "~> 2.7"
gem "jquery-rails", "~> 4.3", ">= 4.3.5"
gem "kaminari", "~> 1.2"
gem "kaminari-bootstrap", "~> 3.0", ">= 3.0.1"
gem "mini_magick", "~> 4.10", ">= 4.10.1"
gem "popper_js", "~> 1.16"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.0"
gem "rails-controller-testing", "~> 1.0", ">= 1.0.4"
gem "rails-i18n"
gem "sass-rails", "~> 5"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg", "0.20.0"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
