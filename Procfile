web: bundle exec rackup config.ru -p $PORT
resque: env TERM_CHILD=1 bundle exec rake resque:work QUEUE=*
rapns: bundle exec rapns $RACK_ENV -f