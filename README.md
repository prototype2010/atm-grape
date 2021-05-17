# Grape ATM 
## Introduction

ATM using grape framework 

## Dependencies

- Ruby 2.7.2
- SQLite 3 

## Installation

- Clone poject
- Run bundler:

 ```shell
 $ bundle install
 ```

- Create database and run migrations:

 ```shell
 $ bundle exec rake db:migrate
 ```

- Run application:

 ```shell
 $ rackup
 ```

## Tests

To execute tests, run the following command:

```shell
$ bundle exec rspec
```

## Routes

To show the application routes, run the following command:

```shell
$ bundle exec rake routes
```
