FROM ruby:2.7.6

RUN apt-get update -qq \
    && apt-get install -y sqlite3 nodejs npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global yarn

ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app
COPY ./litestream.yml /etc/litestream.yml
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]