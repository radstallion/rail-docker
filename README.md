# README
This project is created to demonstrate how to use rails with Docker.

## How to
1. create a file named Gemfile specify source and rails version
    ```
    source "https:/rubygems.org"
    gem "rails","5.0.0"
    ```
    5.0.0 can be replaced with any version.
2. create a blank file Gemfile.lock
3. create a file named Dockerfile
    ```
   FROM ruby:2.3.0

    RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

    Run mkdir /noteapp
    WORKDIR /noteapp

    ADD Gemfile /noteapp/Gemfile
    ADD Gemfile.lock /noteapp/Gemfile.lock

    RUN bundle install

    ADD . /noteapp
    ```
4. create docker-compose.yml
    ```
    version: '2'
    services:
      db:
        image: mysql:5.7
        restart: always
        environment:
          MYSQL_ROOT_PASSWORD: password
          MYSQL_DATABASE: noteapp
          MYSQL_USER: appuser
          MYSQL_PASSWORD: password
        ports:
          - "3307:3306"
      app:
        build: .
        command: bundle exec rails s -p 3000 -b '0.0.0.0'
        volumes:
          - ".:/noteapp"
        ports:
          - "3001:3000"
        depends_on:
          - db
        links:
          - db
        environment:
          DB_USER: root
          DB_NAME: noteapp
          DB_PASSWORD: password
          DB_HOST: db
    ```
