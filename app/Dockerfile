FROM ruby:2.7.1

RUN gem install bundler

WORKDIR /app
COPY ./Gemfile /app
COPY ./Gemfile.lock /app
RUN bundle install

COPY . /app

CMD puma -p 3000
EXPOSE 3000
