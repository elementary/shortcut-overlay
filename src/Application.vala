/*-
 * Copyright (c) 2017 elementary LLC. (https://elementary.io)
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

    protected override void activate () {
        unowned List<Gtk.Window> windows = get_windows ();
        assert (windows.length () <= 1);

        if (windows.length () == 1) {
            var win = windows.data as MainWindow;
            if (win.visible) {
                win.hide ();
                win.can_destroy = true;
                return;
            } else if (win.can_destroy) {
                win.destroy ();
            } else {
                return;
            }
        }

        bool is_terminal = Posix.isatty (Posix.STDIN_FILENO);

        var main_window = new MainWindow (this);
        main_window.show_all ();

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"Escape"});

        if (is_terminal == false) {
            main_window.focus_out_event.connect ((event) => {
                quit_action.activate (null);
                return Gdk.EVENT_STOP;
            });
        }

        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.hide ();
                /* Retain the window for a short time so that the keybinding
                 * listener does not instantiate a new one right after closing
                 */
                Timeout.add (500, () => {
                    main_window.destroy ();
                    return false;
                });
            }
        });

        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });
    }
}

public static int main (string[] args) {
    var application = new ShortcutOverlay.Application ();
    return application.run (args);
}
