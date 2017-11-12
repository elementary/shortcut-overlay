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

public class ShortcutOverlay.MainWindow : Gtk.Window {
    private static Gee.ArrayList<ShortcutEntry> entries;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 640,
            resizable: false,
            title: _("Keyboard Shortcuts"),
            width_request: 910
        );
    }

    static construct {
        entries = new Gee.ArrayList<ShortcutEntry> ();
        entries.add (new ShortcutEntry (_("Applications Menu:"), "org.gnome.desktop.wm.keybindings", "panel-main-menu"));
        entries.add (new ShortcutEntry (_("Multitasking View:"), "org.gnome.desktop.wm.keybindings", "show-desktop"));
        entries.add (new ShortcutEntry (_("Switch windows:"), "org.gnome.desktop.wm.keybindings", "switch-windows"));   
        entries.add (new ShortcutEntry (_("Switch workspaces:"), "org.pantheon.desktop.gala.keybindings", "cycle-workspaces-next"));             
    }

    construct {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("io/elementary/shortcut-overlay/application.css");
        Gtk.StyleContext.add_provider_for_screen (get_screen (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 12;
        layout.hexpand = true;
        layout.margin = 12;

        var key_label = new Gtk.Label (_("⌘"));
        key_label.halign = Gtk.Align.END;
        key_label.get_style_context ().add_class ("keycap");
        key_label.hexpand = true;

        foreach (var entry in entries) {
            var label = new ShortcutLabel (entry);

            layout.add (label);
        }

        var action_label = new Gtk.Label (_("Application launcher"));
        action_label.halign = Gtk.Align.START;
        action_label.hexpand = true;


        add (layout);
    }
}
