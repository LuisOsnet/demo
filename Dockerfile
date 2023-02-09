FROM ruby:3.1.0

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ruby-dev \
  git \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Setup app location
RUN mkdir -p /app
WORKDIR /app

# Install gems
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler && bundle install --jobs=4 --retry=3 

EXPOSE 3000