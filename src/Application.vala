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
        if (windows.length () > 0) {
            windows.data.present ();
            return;
        }

        var main_window = new MainWindow (this);
        main_window.show_all ();

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        add_accelerator ("Escape", "app.quit", null);

        main_window.focus_out_event.connect ((event) => {
            quit_action.activate (null);
            return main_window.focus_out_event(event);
        });

        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.destroy ();
            }
        });
    }
}

public static int main (string[] args) {
    var application = new ShortcutOverlay.Application ();
    return application.run (args);
}
