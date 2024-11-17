FROM ruby:3.3

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3003

# ENTRYPOINT ["bundle exec rage", "server", "-e","production", "-b", "0.0.0.0"]
CMD ["/usr/local/bundle/bin/rage", "server", "-e", "production", "-b", "0.0.0.0"]
