/*-
 * Copyright (c) 2017–2018 elementary LLC. (https://elementary.io)
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

public class ShortcutOverlay.MainWindow : Gtk.Window {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            resizable: false,
            title: _("Shortcuts")
        );
    }

    construct {
        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 24) {
            margin_start = 36,
            margin_end = 36,
            margin_top = 12,
            margin_bottom = 24
        };

        var shortcuts_view = new ShortcutsView ();

        var settings_button = new Gtk.Button.with_label (_("Keyboard settings…")) {
            hexpand = false,
            halign = Gtk.Align.END
        };
        
        box.append (shortcuts_view);
        box.append (settings_button);
        child = box;

        var start_controls = new Gtk.WindowControls (Gtk.PackType.START);

        var title_label = new Gtk.Label (_("Shortcuts")) {
            hexpand = true
        };
        title_label.add_css_class (Granite.STYLE_CLASS_TITLE_LABEL);

        var end_controls = new Gtk.WindowControls (Gtk.PackType.END);

        var titlebar = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        titlebar.append (start_controls);
        titlebar.append (title_label);

        if (!end_controls.empty) {
            titlebar.append (end_controls);
        }

        titlebar.add_css_class (Granite.STYLE_CLASS_FLAT);
        titlebar.add_css_class (Granite.STYLE_CLASS_DEFAULT_DECORATION);

        set_titlebar (titlebar);

        settings_button.clicked.connect (() => {
            try {
                AppInfo.launch_default_for_uri ("settings://input/keyboard/shortcuts", null);
            } catch (Error e) {
                warning (e.message);
            }
        });
    }
}
