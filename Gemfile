source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "dotenv-rails"
gem "fast_jsonapi"
gem "graphql"
gem "jwt"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "rails", "~> 7.0.5"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "shoulda-matchers"
end

group :development do
  gem "annotate"
  gem "solargraph"
end

gem "dockerfile-rails", ">= 1.5", :group => :development
