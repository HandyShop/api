# HandyShop
[![Build Status](https://travis-ci.org/HandyShop/api.svg?branch=master)](https://travis-ci.org/HandyShop/api)
[![codecov](https://codecov.io/gh/HandyShop/api/branch/master/graph/badge.svg)](https://codecov.io/gh/HandyShop/api)


# Configurations
## Database and Environment
Create a PostgreSQL user:
```shell
  bundle install
  bundle exec figaro install
  sudo -u postgres psql
  CREATE ROLE handyshop WITH LOGIN PASSWORD 'your_password' CREATEDB;
```
Set the environment variable `HANDYSHOP_DATABASE_PASSWORD` in config/application.yml
```
  HANDYSHOP_DATABASE_PASSWORD: "your_password"
```

Create the databases and run migrations
```shell
  rake db:create
  rake db:migrate
```
