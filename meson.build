project(
    'io.elementary.shortcut-overlay',
    'vala', 'c',
    version: '1.2.0'
)

gnome = import('gnome')
i18n = import('i18n')

asresources = gnome.compile_resources(
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_global_arguments([
        '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
        '-DHANDY_USE_UNSTABLE_API'
    ],
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

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/ShortcutLabel.vala',
    'src/Views/ShortcutsView.vala',
    config_file,
    asresources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite', version: '>= 5.4.0'),
        dependency('gtk+-3.0'),
        dependency('gee-0.8'),
        dependency('libhandy-1', version: '>=0.80.0'),
        meson.get_compiler('vala').find_library('posix'),
    ],
    install : true
)

subdir('data')
subdir('po')
