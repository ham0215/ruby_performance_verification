FROM debian:10.1

ENV RUBY_VERSION 2.6.3

RUN apt update && apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    default-libmysqlclient-dev \
    rbenv \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
RUN mkdir -p "$(rbenv root)"/plugins
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
RUN RUBY_BUILD_SKIP_MIRROR=1 rbenv install $RUBY_VERSION
RUN rbenv global $RUBY_VERSION
RUN rbenv rehash

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

#RUN rbenv exec gem install bundler:1.17.2
RUN rbenv exec gem install bundler
RUN rbenv exec bundle install
COPY . .
#RUN yarn install --check-files

RUN rm -f /app/tmp/pids/server.pid

CMD ["rails", "server", "-b", "0.0.0.0"]
