project('io.elementary.shortcut-overlay', 'vala', 'c')

gnome = import('gnome')

asresources = gnome.compile_resources(
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_global_arguments('-DGETTEXT_PACKAGE="io.elementary.shortcut-overlay"', language:'c')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/ShortcutEntry.vala',
    'src/ShortcutLabel.vala',
    asresources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('gee-0.8'),
    ],
    install : true
)
