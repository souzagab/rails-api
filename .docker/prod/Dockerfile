# Production Dockerfile
ARG RUBY_IMAGE=ruby:3.2-alpine3.17

FROM $RUBY_IMAGE as build

ARG USER_ID=1000
ARG GROUP_ID=1000

ARG USER=app
ARG GROUP=app
ARG APP_PATH=/rails-api

ENV APP_PATH $APP_PATH

ARG PG_VERSION=15

RUN apk add --update --no-cache tzdata bash less \
  && apk add --no-cache --virtual .base build-base libxml2-dev libxslt-dev  \
  && apk add --no-cache postgresql${PG_VERSION}-dev postgresql${PG_VERSION}-client

RUN addgroup -g $GROUP_ID -S $GROUP \
  && adduser -s /sbin/nologin -u $USER_ID -G $GROUP $USER -S

ENV APP_PATH $APP_PATH

COPY .docker/common/entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

RUN gem update --system \
  && mkdir -p $APP_PATH/vendor/bundle \
  && chown $USER_ID:$GROUP_ID -R $APP_PATH

WORKDIR $APP_PATH

COPY --chown=$USER_ID:$GROUP_ID . $APP_PATH

RUN bundle config --global frozen true \
  && bundle config path "vendor/bundle" \
  && bundle config without development:test:assets \
  && bundle install --retry 3 --jobs 4

FROM $RUBY_IMAGE as release

ARG USER_ID=1000
ARG GROUP_ID=1000

ARG USER=app
ARG GROUP=app
ARG APP_PATH=/rails-api

ENV APP_PATH $APP_PATH
ENV RAILS_ENV production

RUN apk add --update --no-cache libpq-dev tzdata

COPY --from=build /usr/bin/entrypoint.sh /usr/bin/

USER root

COPY --from=build --chown=$USER_ID:$GROUP_ID /usr/local/bundle/config /usr/local/bundle/config
COPY --from=build --chown=$USER_ID:$GROUP_ID $APP_PATH $APP_PATH

WORKDIR $APP_PATH

RUN bundle config path "vendor/bundle"

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
