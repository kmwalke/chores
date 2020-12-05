#!/bin/bash
psql -h $DB_HOST -d $DB_DEV -U $DB_USERNAME -c 'SELECT id FROM users LIMIT 1'

if [ $? == 0 ]; then
  echo "DB already set up"
else
  echo "Setting up the DB"
  bundle exec rails db:create
  bundle exec rails db:schema:load
  bundle exec rails db:seed
fi

bundle exec rails db:migrate RAILS_ENV=development
bundle exec rails db:migrate RAILS_ENV=test

bundle exec puma -p 3000 -C config/puma.rb
