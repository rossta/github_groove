source "https://rubygems.org"

gem "bundler"
gem "rake"
gem "hanami",       "0.7.0"
gem "hanami-model", "~> 0.5"
gem "pg"

gem "pony"
gem "groovehq", github: "rossta/groovehq", branch: "paginated_collection"
gem "omniauth-github", github: "intridea/omniauth-github"
gem "warden"

group :test do
  gem "minitest"
  gem "capybara"
  gem "rubocop", "~> 0.36"
  gem "m"
end

group :test, :development do
  gem "pry-byebug"
end

group :production do
  # gem 'puma'
end
