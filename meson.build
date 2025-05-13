project(
    'io.elementary.shortcut-overlay',
    'vala', 'c',
    version: '8.0.1'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language:'c'
)

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

subdir('data')
subdir('po')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/ShortcutLabel.vala',
    'src/Views/ShortcutsView.vala',
    gresource,
    config_file,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite-7', version: '>= 7.0.0'),
        dependency('gtk4'),
        dependency('gee-0.8'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install : true
)
