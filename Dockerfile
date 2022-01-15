FROM ruby:3.0.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  \
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends  \
    fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcups2  \
    libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 libxcomposite1 libxdamage1 libxfixes3 xdg-utils  \
    nodejs yarn  \
    postgresql-client  \
    build-essential  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  \
    && dpkg -i google-chrome-stable_current_amd64.deb
RUN wget https://chromedriver.storage.googleapis.com/97.0.4692.71/chromedriver_linux64.zip  \
    && unzip chromedriver_linux64.zip  \
    && mv chromedriver /usr/local/bin/  \
    && chmod 755 /usr/local/bin/chromedriver
RUN yum install ipa-pgothic-fonts.noarch

WORKDIR /serurepo

COPY . /serurepo

RUN gem install bundler
RUN bundle install
RUN yarn install
