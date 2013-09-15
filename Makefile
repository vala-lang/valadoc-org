
default: generator doclet.so update-girs configgen example-gen

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
	rm -f valadoc-example-gen
	rm -f configgen
	rm -f generator
	rm -R -f girs
	rm -R -f tmp
	rm -f *.so
	rm -f LOG


example-gen:
	valac -o valadoc-example-gen src/valadoc-example-parser.vala src/valadoc-example-gen.vala

doclet.so:
	valac -o doclet src/doclet.vala src/linkhelper.vala --pkg gee-0.8 --pkg valadoc-1.0 -C
	gcc -shared -fPIC `pkg-config --cflags --libs glib-2.0 gmodule-2.0 gee-0.8 valadoc-1.0` -o libdoclet.so src/doclet.c src/linkhelper.c
	rm -R -f src/*.c



generator: doclet.so
	valac -o generator src/doclet.vala src/linkhelper.vala src/generator.vala --pkg gee-0.8 --pkg valadoc-1.0

configgen:
	valac -o configgen src/configgen.vala -X -D -X datadir=\"$(datadir)\" --vapidir src/ --pkg config

update-girs:
	if test -d girs; then \
		cd girs ; \
		git pull ; \
		cd .. ; \
	else \
		git clone git://gitorious.org/vala-girs/vala-girs.git girs ; \
	fi

