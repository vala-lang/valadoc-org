#!/usr/bin/bash

#find vapidir
vapidir="/usr/share/vala-`vala --api-version | awk -F. '{ print "0."$$2 }'`/vapi"

# build and install binaries
meson setup --prefix=/usr/local build
meson compile -C build
sudo meson install -C build

generator \
  --vapidir=$vapi \
  --vapidir=$(pwd)/extra-vapis/ \
  --vapidir=girs/vala/vapi/ \
  --prefix=stable \
  --target-glib 2.98 \
  --download-images \
  --no-check-certificate \
  --disable-devhelp --skip-existing \
  --doclet=./libdoclet.so \
  glib-2.0 gobject-2.0 gio-2.0 #--all

