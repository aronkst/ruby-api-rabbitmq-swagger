FROM ruby:3.2.2-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential libpq-dev postgresql-client \
  && apt-get clean

RUN gem update --system && gem install bundler

RUN gem install puma -v 6.2.2
RUN gem install sinatra -v 3.0.6

WORKDIR /usr/src/app

COPY . .

RUN bundle check || bundle install --jobs 4
