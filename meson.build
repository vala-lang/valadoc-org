project('valadoc-org', 'c', 'vala')

glib_dep = dependency('glib-2.0')
gio_dep = dependency('gio-2.0')
soup_dep = dependency('libsoup-2.4')
json_glib_dep = dependency('json-glib-1.0')

compose_dep = dependency('compose-1.0', fallback: ['compose', 'compose'])
glrucache_dep = dependency('glrucache', fallback: ['glrucache', 'glrucache_dep'])
vsgi_dep = dependency('vsgi-1.0', fallback: ['vsgi', 'vsgi_dep'])
valum_dep = dependency('valum-0.4', fallback: ['valum', 'valum_dep'])

mysql_dep = declare_dependency(dependencies: meson.get_compiler('vala').find_library('mysql'),
                               c_args: run_command('mysql_config', '--cflags').stdout().split(),
                               link_args: run_command('mysql_config', '--libs').stdout().split())

subdir('src')
