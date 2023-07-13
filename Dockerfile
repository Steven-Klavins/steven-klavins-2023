# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.0.3
FROM ruby:$RUBY_VERSION

# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql nodejs npm yarn && \
    apt-get clean && \
    apt-get update ca-certificates && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man


# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"


  WORKDIR /app
  COPY Gemfile* .
  RUN bundle install
  COPY . .
  EXPOSE 3000
  CMD ["rails", "server", "-b", "0.0.0.0"]