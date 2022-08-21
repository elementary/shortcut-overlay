/*-
 * Copyright 2017–2022 elementary, Inc. (https://elementary.io)
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
        var shortcuts_view = new ShortcutsView ();

        var settings_button = new Gtk.LinkButton.with_label ("settings://input/keyboard/shortcuts", _("Keyboard Settings…")) {
            halign = Gtk.Align.END
        };

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 24) {
            margin_start = 36,
            margin_end = 36,
            margin_top = 12,
            margin_bottom = 24
        };
        box.append (shortcuts_view);
        box.append (settings_button);
        child = box;
        
        var titlebar = new Gtk.HeaderBar ();
        titlebar.add_css_class (Granite.STYLE_CLASS_FLAT);
        titlebar.add_css_class (Granite.STYLE_CLASS_DEFAULT_DECORATION);

        set_titlebar (titlebar);
    }
}
