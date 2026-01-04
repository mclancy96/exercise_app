source "https://rubygems.org"

gem "erb_lint"
gem "importmap-rails"
gem "jbuilder"
gem "playbook_ui"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 8.0.0"
gem "sassc-rails"

group :production do
  gem "pg"
end
gem "stimulus-rails"
gem "turbo-rails"
gem "view_component"

gem "tzinfo-data", platforms: %i[windows jruby]

gem "solid_cable"
gem "solid_cache"
gem "solid_queue"

gem "bootsnap", require: false

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rubocop-rails", require: false
  gem "sqlite3", ">= 2.1"
end

group :development do
  gem "web-console"
end
