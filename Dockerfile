# import image
FROM ruby:3.0.0-alpine

# installed for apple silicon
RUN apk add gcompat

# install dependencies for application
RUN apk add --update --virtual \
runtime-deps \
postgresql-client \
build-base \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
libffi-dev \
readline \
build-base \
postgresql-dev \
libc-dev \
linux-headers \
readline-dev \
file \
imagemagick \
git \
tzdata \
&& rm -rf /var/cache/apk/*

# select working directory and copy files there
WORKDIR /app
COPY . /app

# install bundle and yarn
ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

# command (with options) to run when doker starts
ENTRYPOINT [ "bin/rails" ]
CMD [ "s", "-b", "0.0.0.0" ]

# expose the port
EXPOSE 3000


# you can docker build after ^
# build downloads images, install dependencies and runs commands specified. (dont need to run again unless to rebuild)
# docker build --tag docker-app-tag .

# docker run to run the app
# docker run -p 3000:3000 docker-app-tag