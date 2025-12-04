/*-
 * Copyright 2017-2022 elementary. Inc. (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class ShortcutOverlay.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "io.elementary.shortcut-overlay",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void startup () {
        base.startup ();

        Granite.init ();
    }

    protected override void activate () {
        unowned List<Gtk.Window> windows = get_windows ();
        if (windows.length () > 0) {
            windows.data.destroy ();
            return;
        }

        var main_window = new MainWindow (this);
        main_window.present ();

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"Escape", "<Ctrl>Q"});

        if (!Posix.isatty (Posix.STDIN_FILENO)) {
            var focus_controller = new Gtk.EventControllerFocus ();
            focus_controller.leave.connect (() => {
                quit_action.activate (null);
            });

            ((Gtk.Widget) main_window).add_controller (focus_controller);
        }


        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.hide ();
                /* Retain the window for a short time so that the keybinding
                 * listener does not instantiate a new one right after closing
                 */
                Timeout.add (500, () => {
                    main_window.destroy ();
                    return GLib.Source.REMOVE;
                });
            }
        });
    }
}

public static int main (string[] args) {
    GLib.Intl.setlocale (LocaleCategory.ALL, "");
    GLib.Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
    GLib.Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
    GLib.Intl.textdomain (GETTEXT_PACKAGE);

    var application = new ShortcutOverlay.Application ();
    return application.run (args);
}
