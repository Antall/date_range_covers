FROM 905242448677.dkr.ecr.us-east-1.amazonaws.com/ruby:2.7 as builder

WORKDIR /usr/src/app

COPY Gemfile* .
COPY date_range_covers.gemspec .
COPY lib/date_range_covers/version.rb ./lib/date_range_covers/

RUN gem install bundler -v 2.2 \
    && bundle config path vendor/bundle \
    && bundle install