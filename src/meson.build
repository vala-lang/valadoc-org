standard_deps = [glib_dep, gobject_dep]
doclet_deps = standard_deps + [libgee_dep, valadoc_dep]
generator_deps = doclet_deps + [gio_dep]

valadoc_example_gen_sources = [
  'valadoc-example-parser.vala',
  'valadoc-example-gen.vala',
]
valadoc_example_gen = executable('valadoc-example-gen', valadoc_example_gen_sources,
  dependencies: standard_deps,
  install: true,
)

valadoc_example_tester_sources = [
  'valadoc-example-parser.vala',
  'valadoc-example-tester.vala',
]
valadoc_example_tester = executable('valadoc-example-tester', valadoc_example_tester_sources,
  dependencies: standard_deps,
  install: true,
)

libdoclet_sources = [
  'doclet.vala',
  'linkhelper.vala',
]
libdoclet = shared_library('doclet', libdoclet_sources,
  dependencies: doclet_deps,
  install: true,
  install_dir: meson.source_root(),
)

generator_sources = [
  'doclet.vala',
  'linkhelper.vala',
  'generator.vala',
]
generator = executable('generator', generator_sources,
  dependencies: generator_deps,
  install: true,
)

configgen_sources = [
  'configgen.vala',
]
configgen = executable('configgen', configgen_sources,
  dependencies: standard_deps + [meson.get_compiler('vala').find_library('config', dirs: meson.current_source_dir())],
  c_args: ['-D', 'datadir="' + get_option('datadir') + '"'],
  install: true,
)

