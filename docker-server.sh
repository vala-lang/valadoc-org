#!/bin/bash

cd /opt/valadoc && searchd -c /opt/valadoc/sphinx.conf
apache2-foreground
