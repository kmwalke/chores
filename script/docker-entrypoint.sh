#!/bin/bash

bundle check || bundle install --jobs 20 --retry 5
yarn install --check-files

exec "$@"
