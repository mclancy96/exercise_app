FROM ruby:3.3.6-slim

ENV RAILS_ENV=production \
    BUNDLE_WITHOUT=development:test \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR /rails

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libyaml-dev \
    nodejs \
    npm \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && bundle install

COPY . .

RUN bundle exec rails assets:precompile

EXPOSE 3000

ENTRYPOINT ["./bin/docker-entrypoint"]
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
