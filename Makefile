

default: generator doclet.so update-girs



clean:
	rm -f generator
	rm -R -f girs
	rm -R -f tmp
	rm -f *.so
	rm -f LOG



doclet.so:
	valac -o doclet src/doclet.vala --pkg gee-1.0 --pkg valadoc-1.0 -C
	gcc -shared -fPIC `pkg-config --cflags --libs glib-2.0 gmodule-2.0 gee-1.0 valadoc-1.0` -o libdoclet.so src/doclet.c
	rm -R -f src/*.c



generator: doclet.so
	valac -o generator src/doclet.vala src/generator.vala --pkg gee-1.0 --pkg valadoc-1.0



update-girs:
	if test -d girs; then \
		cd girs ; \
		git pull ; \
		cd .. ; \
	else \
		git clone git://gitorious.org/vala-girs/vala-girs.git girs ; \
	fi




