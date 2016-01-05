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
$ make serve
```
and navigate your browser to `localhost:7777`.
