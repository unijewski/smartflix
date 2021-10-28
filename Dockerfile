FROM ruby:2.7.2

ENV WORKDIR /app

WORKDIR $WORKDIR

COPY . $WORKDIR

RUN bundle install

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN yarn install --check-files

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
