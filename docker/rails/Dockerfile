FROM ruby:2.6.5

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn chromium-driver
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
  apt-get install -y nodejs

ADD Gemfile /fit_care_health/Gemfile
ADD Gemfile.lock /fit_care_health/Gemfile.lock

RUN gem install bundler
RUN bundle install

WORKDIR /fit_care_health

COPY . /fit_care_health
COPY ./docker/rails/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 5000

CMD ["rails", "server", "-b", "0.0.0.0"]