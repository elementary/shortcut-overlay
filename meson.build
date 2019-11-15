project(
    'io.elementary.shortcut-overlay',
    'vala', 'c',
    version: '1.1.0'
)

gnome = import('gnome')
i18n = import('i18n')

asresources = gnome.compile_resources(
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_global_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language:'c'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/ShortcutLabel.vala',
    'src/Views/ShortcutsView.vala',
    asresources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite', version: '>= 5.2.0'),
        dependency('gtk+-3.0'),
        dependency('gee-0.8'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install : true
)

subdir('data')
subdir('po')
