valadoc_app_sources = [
  'valadoc-app.vala',
  'valadoc-app-database.vala']
  valadoc_app_deps = [
    glib_dep,
    gio_dep,
    soup_dep,
    mysql_dep,
    vsgi_dep,
    valum_dep,
    compose_dep,
    json_glib_dep,
    glrucache_dep]
  executable('valadoc-app', valadoc_app_sources,
             dependencies: valadoc_app_deps)
