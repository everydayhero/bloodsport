FROM ruby:2.2.1-wheezy
MAINTAINER Jonathon M. Abbott <jonathona@everydayhero.com.au>

RUN apt-get update
RUN apt-get install -y libqt4-dev wkhtmltopdf xvfb

RUN mkdir /srv/app
ENV HOME /srv/app
WORKDIR /srv/app/

ADD Gemfile* /srv/app/
RUN mkdir /srv/app/gemspecs
ADD components/*/*.gemspec /srv/app/gemspecs/
RUN bundle install

ADD . /srv/app/
RUN rm -rf gemspecs && \
    bundle install && \
    mkdir -p .git/objects && git rev-parse HEAD > REVISION && \
    bin/generate_libexec && \
    cd / && ln -s /srv/app/libexec/* ./ && \
    cd /srv/app && ln -s /srv/app/libexec/* ./
