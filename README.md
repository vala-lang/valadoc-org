Valadoc-org
===========

Stays crunchy even in milk.

Building
========

In order to build the docs you will need the following packages:
* `valadoc` past [this](https://git.gnome.org/browse/valadoc/commit/) patch
* `php`

On elementary OS or Ubuntu run:
```bash
$ sudo apt-get install libvaladoc-dev php5
```

Arch or derivatives run:
```bash
$ yaourt -S valadoc-git php
```

After you have `valadoc` installed, you can move to building the documentation. Simply run:

```bash
$ make
$ make build-docs
```

and grab yourself a cup of coffee. This will take a bit of time. If you encounter an error at this step, please see the [common pitfalls](#Common-Pitfalls) section. After you completed building you should see a `valadoc.org` folder.

To access the documentation run
```bash
$ cd valadoc.org
$ php -S localhost:8000
```
and navigate your browser to `localhost:8000`.

Common Pitfalls
===============

```bash
ERROR: Can't generate documentation for packagekit-glib2. See LOG for details.
```
Comment out packagekit-glib2 in `documentation/package.xml`. It should look like this:
```xml
<!--
<package name="packagekit-glib2" gir="PackageKitGlib-1.0" home="http://www.packagekit.org/" c-docs="http://www.freedesktop.org/software/PackageKit/gtk-doc/">
	Library for accessing PackageKit using GLib.
</package>
-->
```
