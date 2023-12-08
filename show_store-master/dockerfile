FROM ruby:2.7.6

# Install the necessary libraries
RUN apt-get update -qq && apt-get install -y postgresql-client

# BUNDLE_FROZEN setting
RUN bundle config --global frozen 1

# Set working directory
WORKDIR /articles-api

# Copy and install the project gems
COPY Gemfile /articles-api/Gemfile
COPY Gemfile.lock /articles-api/Gemfile.lock
RUN bundle install
RUN bundle exec rails assets:precompile
RUN rails active_storage:install
RUN rails g rails_admin:install
RUN rails db:migrate

# Run entrypoint.sh to delete server.pid
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Listen on this specified network port
EXPOSE 3000

# Run rails server
CMD ["rails", "server", "-b", "0.0.0.0"]