FROM ruby:2.4
MAINTAINER m510.net

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install locales
RUN sed -i -e "s/# ja_JP.*/ja_JP.UTF-8 UTF-8/" /etc/locale.gen
RUN dpkg-reconfigure -f noninteractive locales
#RUN update-locale LANG=ja_JP.UTF-8
ENV LANG ja_JP.UTF-8


#RUN gem install bundler --no-rdoc --no-ri
RUN apt-get install -y build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev \
postgresql postgresql-server-dev-all \
apache2 apache2-dev libapr1-dev libaprutil1-dev \
imagemagick libmagick++-dev fonts-takao-gothic \
subversion git \
sudo
# install redmine
RUN wget http://www.redmine.org/releases/redmine-3.4.2.tar.gz -q -O- | tar zxf -
RUN mv redmine-* /var/lib/redmine
RUN chown -R www-data /var/lib/redmine
WORKDIR /var/lib/redmine
RUN sudo -u www-data bundle install --without development test --path vendor/bundle

# install passenger
RUN gem install passenger --no-rdoc --no-ri
RUN passenger-install-apache2-module --auto --languages ruby

