npm install
npm run build
RAILS_ENV=$RAILS_ENV bundle exec rake db:schema:load import:data
RAILS_ENV=$RAILS_ENV bundle exec rake cf:on_first_instance db:migrate && exec bundle exec rails s -p $PORT -e $RAILS_ENV
