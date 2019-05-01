# Dockerfile
## Builds valadoc and serves it with a basic PHP server

# Build valadoc
FROM ubuntu:18.04 as build-docs

# Install basic needed packages
RUN apt update && apt install -y --no-install-recommends software-properties-common

# Install third party repos
RUN add-apt-repository -y ppa:vala-team

# Install valadoc and server packages
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install \
  -y \
  --no-install-recommends \
  gcc \
  gee-0.8 \
  git \
  libguestfs-gobject-1.0 \
  libvaladoc-dev \
  php \
  php-curl \
  sphinxsearch \
  unzip \
  valac \
  valadoc \
  wget \
  xsltproc

# Copy over the valadoc stuff
COPY . /opt/valadoc
WORKDIR /opt/valadoc

# Build docs
RUN make build-docs || true

# Build search index
RUN make configgen \
  && ./configgen ./valadoc.org/ \
  && mkdir ./sphinx/storage \
  && indexer --config ./sphinx.conf --all

# Build valadoc assets
FROM node:10 as build-assets

# Copy over the valadoc stuff
COPY --from=build-docs /opt/valadoc /opt/valadoc
WORKDIR /opt/valadoc

# Build website assets
RUN make build-data

# Cleanup and publish
FROM php:apache

# Install sphinxsearch for search index
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install \
  -y \
  --no-install-recommends \
  sphinxsearch

# Install the mysqli extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy over all of the valadoc sphinx search data and configuration
RUN mkdir -p /opt/valadoc
COPY --from=build-assets /opt/valadoc/sphinx.conf /opt/valadoc/sphinx.conf
COPY --from=build-assets /opt/valadoc/sphinx /opt/valadoc/sphinx

# Copy over the build static html files
COPY --from=build-assets /opt/valadoc/valadoc.org /var/www/html

# A couple default apache changes to make valadoc work
COPY apache.conf /etc/apache2/sites-available/000-default.conf

COPY docker-server.sh /usr/local/bin/valadoc
CMD ["valadoc"]
