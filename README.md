# README
Ruby performance verification on Rails

## OS
debian:10.1

## Rails version
6.0.0

## rails new
```
bundle exec rails new . --skip-action-text --skip-turbolinks --skip-spring --force --database=mysql --skip-bootsnap --skip-test
```

## set Ruby version
Change ruby version in Dockerfile.
```
ENV RUBY_VERSION x.y.z
```
Rebuild and rails s
```
# build
docker-compose build --no-cache
# run in background
docker-compose up -d
```

## run performance verification
```
```