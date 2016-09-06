#!/bin/bash

set -xeu

bundle exec rake cf:on_first_instance import:data
bundle exec rake cf:on_first_instance db:migrate && exec bundle exec rails s -p $PORT -e $RAILS_ENV
