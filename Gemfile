source "https://rubygems.org"

gem "bundler"
gem "rake"
gem "puma"
gem "hanami",       "0.7.2"
gem "hanami-model"
gem "pg"

gem "pony"
gem "groovehq", github: "rossta/groovehq", branch: "paginated_collection"
gem "omniauth-github", github: "intridea/omniauth-github"
gem "warden"
gem "octokit"

gem "sucker_punch", "~> 2.0"

group :test do
  gem "minitest"
  gem "capybara_minitest_spec"
  gem "capybara"
  gem "rubocop", "~> 0.36"
  gem "m"
  gem "launchy"
  gem "webmock"
end

group :test, :development do
  gem "pry-byebug"
end

group :production do
  # gem 'puma'
end
