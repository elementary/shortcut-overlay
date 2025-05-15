# Shortcut Overlay
[![Translation status](https://l10n.elementary.io/widgets/desktop/-/shortcut-overlay/svg-badge.svg)](https://l10n.elementary.io/engage/desktop/?utm_source=widget)

A native OS-wide shortcut overlay to be launched by Gala.

This GTK+ applet reads window manager and OS keyboard shortcuts from dconf
and exposes them to the user when launched. Inspired by the similar [feature][1]
of Ubuntu Unity introduced in Ubuntu 12.04.

![Screenshot](/data/Screenshot@2x.png)

The shortcut window opens centered on the primary display. The gear in the titlebar opens the [system keyboard settings](settings://input/keyboard/shortcuts).

## Included Shortcuts

We need to decide which shortcuts are included, how they're sorted, and if they're grouped into smaller categories. [Read this document](https://paper.dropbox.com/doc/elementary-OS-Shortcut-Overlay-z3oP5UefS11B2OpOZpKE5?_tk=share_copylink) to that effect.

## Building, Testing, and Installation

You'll need the following dependencies:
* libgee-0.8-dev
* libgranite-7-dev >= 7.3.0
* libgtk-4-dev
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
