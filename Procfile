web: bundle exec rackup config.ru -p $PORT
rapns: bundle exec rapns $RACK_ENV -f
resque: env TERM_CHILD=1 bundle exec rake resque:work QUEUE=* VERBOSE=true

