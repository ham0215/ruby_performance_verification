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
# create database. migrate. load the data.
docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose run web rake db:seed_fu
# run in background
docker-compose up -d
```

## run performance verification
```
$ ./bin/request_100.sh
##################### (100%)
---------------------------------------------------------
Number of valid responses
100
Average response time
0.0431709
```