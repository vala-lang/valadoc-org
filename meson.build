project('valadoc-org', 'vala', 'c')

vala_api_version = run_command (meson.get_compiler('vala'), '--api-version', check: true).stdout().strip()
data_dir = meson.current_source_dir()

config_vapi = meson.get_compiler('vala').find_library('config', dirs: meson.current_source_dir() / 'src')

config_dep = declare_dependency(
  dependencies: config_vapi
)

gee_dep = dependency('gee-0.8')
valadoc_dep = dependency('valadoc-@0@'.format(vala_api_version))
libvala_dep = dependency('libvala-@0@'.format(vala_api_version))
gio_dep = dependency('gio-2.0')
glib_dep = dependency('glib-2.0')
gobject_dep = dependency('gobject-2.0')

example_gen = executable(
  'valadoc-example-gen',
  'src/valadoc-example-parser.vala',
  'src/valadoc-example-gen.vala',
  dependencies: [
    glib_dep,
    gobject_dep,
  ]
)

example_tester = executable(
  'valadoc-example-tester',
  'src/valadoc-example-parser.vala',
  'src/valadoc-example-tester.vala',
  dependencies: [
    glib_dep,
    gobject_dep,
  ]
)

doclet = shared_module(
  'doclet',
  'src/doclet.vala',
  'src/linkhelper.vala',
  dependencies: [
    glib_dep,
    gobject_dep,
    gee_dep,
    valadoc_dep,
  ]
)

generator = executable(
  'generator',
  'src/doclet.vala',
  'src/linkhelper.vala',
  'src/generator.vala',
  dependencies: [
    glib_dep,
    gobject_dep,
    gio_dep,
    gee_dep,
    valadoc_dep,
  ]
)

configgen = executable(
  'configgen',
  'src/configgen.vala',
  dependencies: [
    glib_dep,
    gobject_dep,
    config_dep,
  ],
  c_args : [
    '-Ddatadir="@0@"'.format(data_dir),
  ],
)

#
# Example checks:
#

examples_files = files(
  'examples/cairo/cairo.valadoc.examples',
  'examples/gee-0.8/gee-0.8.valadoc.examples',
  'examples/gio-2.0/gio-2.0.valadoc.examples',
  'examples/glib-2.0/glib-2.0.valadoc.examples',
  'examples/gmodule-2.0/gmodule-2.0.valadoc.examples',
  'examples/gmodule-2.0/gmodule-2.0.valadoc.examples',
  'examples/gobject-2.0/gobject-2.0.valadoc.examples',
  'examples/gstreamer-1.0/gstreamer-1.0.valadoc.examples',
  'examples/gstreamer-video-1.0/gstreamer-video-1.0.valadoc.examples',
  'examples/gtk+-3.0/gtk+-3.0.valadoc.examples',
  'examples/json-glib-1.0/json-glib-1.0.valadoc.examples',
  'examples/libnotify/libnotify.valadoc.examples',
  'examples/libsoup-2.4/libsoup-2.4.valadoc.examples',
  'examples/libxml-2.0/libxml-2.0.valadoc.examples',
  'examples/rest-0.7/rest-0.7.valadoc.examples',
  'examples/sqlite3/sqlite3.valadoc.examples'
)

run_target('check-examples',
  command: [
    example_tester,
    '--keep-running', '--force',
    examples_files,
  ]
)

#
# Build local assets
#
run_target('build-data',
  command: ['npx', 'gulp',]
)

#
# Documentation generation:
#
packages = get_option('packages')
if packages.length() == 0
  packages = '--all'
endif

run_target('build-docs',
  command: [
    generator,
    '--vapidir', libvala_dep.get_variable('vapidir'),
    '--vapidir', meson.current_source_dir() / 'extra-vapis',
    '--vapidir', meson.current_source_dir() / 'girs/vala/vapi',
    '--prefix', get_option('doc_prefix'),
    '--target-glib', '2.98',
    '--download-images',
    '--no-check-certificate',
    '--directory', meson.current_build_dir() / 'valadoc.org',
    get_option('generator_options'),
    packages
  ]
)

run_target('build-docs-mini',
  command: [
    generator,
    '--vapidir', libvala_dep.get_variable('vapidir'),
    '--vapidir', meson.current_source_dir() / 'extra-vapis',
    '--vapidir', meson.current_source_dir() / 'girs/vala/vapi',
    '--prefix', get_option('doc_prefix'),
    '--target-glib', '2.98',
    '--download-images',
    '--no-check-certificate',
    '--directory', meson.current_build_dir() / 'valadoc.org',
    get_option('generator_options'),
    'glib-2.0',
    'gio-2.0',
    'gobject-2.0',
  ]
)
