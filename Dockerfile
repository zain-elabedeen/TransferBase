FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y postgresql-client

ENV APP_DIR /transferbase
RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY Gemfile $APP_DIR/Gemfile
# COPY Gemfile.lock $APP_DIR/Gemfile.lock

RUN bundle install
COPY . $APP_DIR

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]