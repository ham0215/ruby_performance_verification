FROM debian:10.1

ENV RUBY_VERSION 2.6.5

RUN apt update && apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    default-libmysqlclient-dev \
    rbenv \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV PATH /root/.rbenv/shims:$PATH
RUN mkdir -p "$(rbenv root)"/plugins
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
RUN RUBY_BUILD_SKIP_MIRROR=1 rbenv install $RUBY_VERSION
RUN rbenv global $RUBY_VERSION
RUN rbenv rehash

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install
COPY . .

RUN rm -f /app/tmp/pids/server.pid

CMD ["bundle ", "exec", "rails", "s", "-b", "0.0.0.0"]
