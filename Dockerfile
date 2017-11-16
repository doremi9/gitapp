FROM ruby:2.3.0

WORKDIR /var/www/githubapp

ADD . /var/www/githubapp

ADD Gemfile Gemfile

ADD Gemfile.lock Gemfile.lock

RUN bundle install

EXPOSE 3000

CMD rails s -b 0.0.0.0