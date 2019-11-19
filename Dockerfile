FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y postgresql-client

ENV APP_DIR /transferbase
RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY Gemfile $APP_DIR/Gemfile
COPY Gemfile.lock $APP_DIR/Gemfile.lock

RUN bundle install
COPY . $APP_DIR

# Script to run every time the container starts.
COPY start_script.sh /usr/bin/
RUN chmod +x /usr/bin/start_script.sh
ENTRYPOINT ["start_script.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]