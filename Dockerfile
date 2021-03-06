FROM ruby:2.5.1-alpine3.7

MAINTAINER heycar Engineering <team-engineering@hey.car>

RUN apk add --update ruby-dev build-base \
  libxml2-dev libxslt-dev pcre-dev libffi-dev \
  postgresql-dev git

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
COPY pghero/ /app/pghero

RUN bundle install --binstubs

COPY . .

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=dummytoken assets:precompile

ENV PORT 8080

EXPOSE 8080

CMD puma -C config/puma.rb
