source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "cssbundling-rails"
gem "jsbundling-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end