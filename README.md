# shortcut-overlay

A native OS-wide shortcut overlay to be launched by Gala.

This GTK+ applet should read window manager and OS keyboard shortcuts from dconf
and expose them to the user when launched. Inspired by the similar [feature][1]
of Ubuntu Unity introduced in Ubuntu 12.04.

## Building, Testing, and Installation

You'll need the following dependencies:
* libgtk-3-dev
* meson
* valac


Run `meson build` to configure the build environment and then change to the build directory and run `ninja` to build

    meson build --prefix=/usr
    cd build
    ninja

To install, use `ninja install`, then execute with `io.elementary.shortcut-overlay`

    sudo ninja install
    io.elementary.shortcut-overlay



[1]: https://bugs.launchpad.net/ayatana-design/+bug/855532
