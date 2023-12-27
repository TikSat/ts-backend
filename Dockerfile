FROM ruby:3.3-slim

ENV TZ Etc/UTC
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru
ENV LC_LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

ENV APP_ENV production
ENV RAILS_ENV production
ENV LOG_LEVEL info
ENV PROJECT_ROOT /app

ENV POSTGRES_HOST postgres
ENV POSTGRES_PORT 5432
ENV DATABASE_URL=postgres://postgres:postgres@$POSTGRES_HOST:5432/postgres

##
# Prepare system dependencies
##

# If postgres is not used, postgresql-server-dev-all can be removed
USER root
RUN useradd -u 1000 -s /bin/bash -M -d /app app && \
    \
    apt-get update && apt-get install -y --no-install-recommends locales && \
    sed -i '/ru_RU.UTF-8/s/^# //g' /etc/locale.gen && locale-gen && \
    \
    apt-get install -y --no-install-recommends \
    ca-certificates libxml2-dev libxslt-dev libgcrypt-dev file curl netcat-openbsd wget gnupg make postgresql-server-dev-all git libvips && \
    \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/lists.d/* && apt-get autoremove -y && apt-get clean && apt-get autoclean && \
    mkdir -p /app/bin && \
    wget https://github.com/EmperDeon/healthcheck/releases/download/v0.1.1/healthcheck-linux-amd64 -O /app/bin/healthcheck --quiet


##
# Prepare dependencies for backend and frontend
##

WORKDIR /app
RUN mkdir tmp tmp/pids public
COPY --chown=1000:1000 Gemfile Gemfile.lock /app/


##
# Setup backend dependencies
##

ENV BUNDLE_GEMFILE=/app/Gemfile

# move gem install bundler to separate step when some gems will be slow to install and could be preinstalled
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && \
    gem install -N bundler:2.3.10 && \
    bundle config set without 'development test' && \
    \
    bundle -j "$(nproc)" && \
    \
    apt-get remove -y build-essential && apt-get clean && apt-get autoclean && \
    rm -rf /usr/local/bundle/cache /usr/local/bundle/gems/*/ext/*.o && \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/lib/apt/lists.d/*


##
# Setup Configs
##

COPY bin/*.sh /app/bin/
RUN chmod 755 /app/bin/* && \
    chown 1000:1000 -R /app


##
# Setup Backend
##

COPY --chown=1000:1000 ./ /app


##
# Finish
##

USER 1000

ARG SENTRY_RELEASE=none
ENV SENTRY_RELEASE $SENTRY_RELEASE

VOLUME /app/public/system /app/log

HEALTHCHECK --interval=15s CMD bash -c '/app/bin/liveliness.sh && /app/bin/readiness.sh'

ENTRYPOINT ["/app/bin/prepare.sh"]
CMD ["/app/bin/rails", "server", "-b", "0.0.0.0"]
