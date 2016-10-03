VALAC_VERSION = $(shell vala --version | awk -F. '{ print "0."$$2 }')
PREFIX = "stable"

gee-version = 0.18.0
gee-pc-version = 0.8


default: generator doclet.so update-girs configgen example-gen example-tester

datadir = $(shell dirname $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))



clean:
	rm -f documentation/*/wiki/example-listing.valadoc
	rm -f documentation/*/wiki/example-listing-*.valadoc
	rm -f documentation/*/wiki/widget-gallery.valadoc
	rm -f documentation/*/wiki/devhelp-index.valadoc
	rm -f documentation/*/wiki/index.valadoc
	rm -f documentation/%s/%s.valadoc.metadata
	rm -R -f documentation/*/gallery-images
	rm -R -f documentation/*/gir-images
	rm -f examples/*-examples.valadoc
	rm -f valadoc-example-tester
	rm -f valadoc-example-gen
	rm -f configgen
	rm -f generator
	rm -R -f extra-vapis
	rm -R -f girs
	rm -R -f tmp
	rm -f *.so
	rm -f LOG


example-gen:
	valac -o valadoc-example-gen src/valadoc-example-parser.vala src/valadoc-example-gen.vala -X -w

example-tester:
	valac -o valadoc-example-tester src/valadoc-example-parser.vala src/valadoc-example-tester.vala -X -w

doclet.so:
	valac src/doclet.vala src/linkhelper.vala --pkg gee-0.8 --pkg valadoc-1.0 -C
	gcc -shared -fPIC `pkg-config --cflags --libs glib-2.0 gmodule-2.0 gee-0.8 valadoc-1.0` -o libdoclet.so src/doclet.c src/linkhelper.c -w
	rm -R -f src/*.c

generator: doclet.so
	valac -o generator src/doclet.vala src/linkhelper.vala src/generator.vala --pkg gee-0.8 --pkg valadoc-1.0 --pkg gio-2.0 --enable-experimental -X -w

configgen:
	valac -o configgen src/configgen.vala -X -D -X datadir=\"$(datadir)\" --vapidir src/ --pkg config -X -w --enable-experimental

update-girs:
	if test -d girs; then \
		cd girs ; \
		git pull ; \
		cd .. ; \
	else \
		git clone https://github.com/nemequ/vala-girs.git girs ; \
	fi
	if test -d extra-vapis; then \
		cd extra-vapis ; \
		git pull ; \
		cd .. ; \
	else \
		git clone https://github.com/nemequ/vala-extra-vapis.git extra-vapis ; \
	fi





#
# Example checks:
#

check-examples:
	./valadoc-example-tester --keep-running --force \
                         examples/cairo/cairo.valadoc.examples \
                         examples/gio-2.0/gio-2.0.valadoc.examples \
                         examples/glib-2.0/glib-2.0.valadoc.examples \
                         examples/gmodule-2.0/gmodule-2.0.valadoc.examples \
                         examples/gmodule-2.0/gmodule-2.0.valadoc.examples \
                         examples/gobject-2.0/gobject-2.0.valadoc.examples \
                         examples/gstreamer-1.0/gstreamer-1.0.valadoc.examples \
                         examples/gstreamer-video-1.0/gstreamer-video-1.0.valadoc.examples \
                         examples/gtk+-3.0/gtk+-3.0.valadoc.examples \
                         examples/json-glib-1.0/json-glib-1.0.valadoc.examples \
                         examples/libnotify/libnotify.valadoc.examples \
                         examples/libsoup-2.4/libsoup-2.4.valadoc.examples \
                         examples/libxml-2.0/libxml-2.0.valadoc.examples \
                         examples/rest-0.7/rest-0.7.valadoc.examples \
                         examples/sqlite3/sqlite3.valadoc.examples 



#
# Documentation generation:
#


build-docs:
	rm -r -f tmp/
	./generator \
        --vapidir /usr/share/vala-$(VALAC_VERSION)/vapi/ \
        --vapidir "extra-vapis/" --vapidir "girs/vala/vapi/" \
        --driver $(VALAC_VERSION) \
        --prefix $(PREFIX) \
        --target-glib 2.99 \
        --download-images \
        --skip-existing \
        --no-check-certificate \
        --all
	if ! test -d valadoc.org/gee-$(gee-pc-version); then \
		wget https://git.gnome.org/browse/libgee/snapshot/libgee-$(gee-version).zip ; \
		unzip libgee-$(gee-version).zip ; \
		valadoc -o libgee-$(gee-version)/gee-$(gee-pc-version) --target-glib=2.99 --pkg gio-2.0 libgee-$(gee-version)/gee/*.vala libgee-$(gee-version)/utils/geeutils.vapi --wiki libgee-$(gee-version)/doc/ --doclet . ; \
		mv libgee-$(gee-version)/gee-$(gee-pc-version)/gee-$(gee-pc-version) valadoc.org/ ; \
		rm -r libgee-$(gee-version) libgee-$(gee-version).zip ; \
	fi


build-docs-mini:
	rm -r -f tmp/
	./generator \
        --vapidir /usr/share/vala-$(VALAC_VERSION)/vapi/ \
        --vapidir "extra-vapis/" --vapidir "girs/vala/vapi/" \
        --driver $(VALAC_VERSION) \
        --prefix $(PREFIX) \
        --target-glib 2.99 \
        --download-images \
        --skip-existing \
        --no-check-certificate \
        --disable-devhelp \
        "glib-2.0" "gio-2.0"


test-examples:
	-./valadoc-example-tester examples/*/*.valadoc.examples  
	rm -f -R tmp/

#
# Run a local webserver serving valadoc.org
#

serve: default build-docs
	FWD_SEARCH=1 FWD_TOOLTIP=1 php -S localhost:7777 -t ./valadoc.org
serve-mini: default build-docs-mini
	FWD_SEARCH=1 FWD_TOOLTIP=1 php -S localhost:7777 -t ./valadoc.org
