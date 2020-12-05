#!/usr/bin/env bash

echo 'Starting Postdeploy...'

echo 'Running migrations...'
bundle exec rails db:create
bundle exec rails db:schema:load
bundle exec rails db:migrate
bundle exec rails db:seed
