# syntax=docker/dockerfile:1

FROM ruby:3.2.2-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn


ARG SECRET_KEY_BASE
# Set the working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]
RUN RAILS_ENV=production SECRET_KEY_BASE=${SECRET_KEY_BASE} rails assets:precompile
