web: bundle exec rackup config.ru -p $PORT
resque: env TERM_CHILD=1 bundle exec rake resque:work QUEUE=* VERBOSE=true
rapns: bundle exec rapns $RACK_ENV -f
