# Dockerfile
## Builds valadoc and serves it with a basic PHP server

# Cleanup and publish
FROM php:apache-buster

ENV DEBIAN_FRONTEND=noninteractive

# Install sphinxsearch for search index
RUN apt-get update -qq && apt-get install \
  -qq \
  --no-install-recommends \
  sphinxsearch

# Install the mysqli extension
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copy over all of the valadoc sphinx search data and configuration
RUN mkdir -p /opt/valadoc
COPY sphinx.conf /opt/valadoc/sphinx.conf
COPY sphinx /opt/valadoc/sphinx

# Copy over the build static html files
# This is disabled here as we bind-mount the image to move instead of copy the
# files as we run out of space on GitHub.
# COPY valadoc.org /var/www/html

# A couple default apache changes to make valadoc work
COPY apache.conf /etc/apache2/sites-available/000-default.conf

COPY docker-server.sh /usr/local/bin/valadoc.org
CMD ["valadoc.org"]
