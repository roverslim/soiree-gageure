FROM ruby:2.5.1

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN bundle install
