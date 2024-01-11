# syntax=docker/dockerfile:1

FROM ruby:3.2.2-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev curl gnupg

# Install Node.js (using NodeSource)
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Set the working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application
COPY . .

# Install JavaScript dependencies
RUN yarn install

#Commented out recent thing Jan 8
# Copy the script to the container
# COPY add-google-credentials.sh /app/add-google-credentials.sh

# Make sure the script is executable
# RUN chmod +x /app/add-google-credentials.sh

# Set the script as the entrypoint
# ENTRYPOINT ["sh", "/app/add-google-credentials.sh"]


# ARG for SECRET_KEY_BASE
ARG SECRET_KEY_BASE=defaultsecret

# Precompile assets in production. 
# SECRET_KEY_BASE is needed for Rails to run in production for this step.
RUN RAILS_ENV=production SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec rake assets:precompile



# Expose the port the app runs on
EXPOSE 3000

# Start the Rails app
CMD ["rails", "server", "-b", "0.0.0.0"]
