i18n.merge_file (
    input: 'shortcut-overlay.metainfo.xml.in',
    output: meson.project_name() + '.metainfo.xml',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    type: 'xml',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo'),
)

i18n.merge_file (
    input: 'shortcut-overlay.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root (), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

gresource = gnome.compile_resources(
    'gresource',
    'shortcut-overlay.gresource.xml'
)

test (
    'Validate desktop file',
    find_program('desktop-file-validate'),
    args: join_paths(meson.current_build_dir (), meson.project_name() + '.desktop')
)
