# Development Dockerfile
ARG RUBY_IMAGE=$RUBY_IMAGE

FROM $RUBY_IMAGE as ruby

ARG USER_ID=1000
ARG GROUP_ID=1000

ARG USER=app
ARG GROUP=app
ARG APP_PATH=/rails-api

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
  && chown $USER:$GROUP -R $APP_PATH

VOLUME $APP_PATH/vendor

USER $USER

WORKDIR $APP_PATH

COPY --chown=$USER_ID:$GROUP_ID Gemfile* $APP_PATH/

RUN bundle config path "vendor/bundle" \
  && bundle install --retry 3

COPY --chown=$USER:$GROUP . $APP_PATH/

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
