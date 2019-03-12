/*-
 * Copyright (c) 2018 elementary LLC. (https://elementary.io)
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

public class ShortcutOverlay.ShortcutsView : Gtk.Grid {
    private const string SCHEMA_WM = "org.gnome.desktop.wm.keybindings";
    private const string SCHEMA_GALA = "org.pantheon.desktop.gala.keybindings";
    private const string SCHEMA_MEDIA = "org.gnome.settings-daemon.plugins.media-keys";
    private const string SCHEMA_MUTTER = "org.gnome.mutter.keybindings";

    construct {
        var column_start = new Gtk.Grid ();
        column_start.column_spacing = 12;
        column_start.hexpand = true;
        column_start.orientation = Gtk.Orientation.VERTICAL;
        column_start.row_spacing = 12;

        column_start.add (new Granite.HeaderLabel (_("Windows")));
        column_start.attach (new NameLabel (_("Close window:")), 0, 1);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "close"), 1, 1);
        column_start.attach (new NameLabel (_("Cycle windows:")), 0, 2);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "switch-windows"), 1, 2);
        column_start.attach (new NameLabel (_("Toggle maximized:")), 0, 3);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "toggle-maximized"), 1, 3);
        column_start.attach (new NameLabel (_("Tile left:")), 0, 4);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_MUTTER, "toggle-tiled-left"), 1, 4);
        column_start.attach (new NameLabel (_("Tile right:")), 0, 5);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_MUTTER, "toggle-tiled-right"), 1, 5);
        column_start.attach (new NameLabel (_("Move to left workspace:")), 0, 6);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "move-to-workspace-left"), 1, 6);
        column_start.attach (new NameLabel (_("Move to right workspace:")), 0, 7);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "move-to-workspace-right"), 1, 7);
        column_start.attach (new NameLabel (_("Picture in Picture Mode:")), 0, 8);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "pip"), 1, 8);

        column_start.add (new Granite.HeaderLabel (_("Workspaces")));
        column_start.attach (new NameLabel (_("Multitasking View:")), 0, 11);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "show-desktop"), 1, 11);
        column_start.attach (new NameLabel (_("Switch left:")), 0, 12);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "switch-to-workspace-left"), 1, 12);
        column_start.attach (new NameLabel (_("Switch right:")), 0, 13);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "switch-to-workspace-right"), 1, 13);
        column_start.attach (new NameLabel (_("Switch to first:")), 0, 14);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "switch-to-workspace-first"), 1, 14);
        column_start.attach (new NameLabel (_("Switch to new:")), 0, 15);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "switch-to-workspace-last"), 1, 15);
        column_start.attach (new NameLabel (_("Cycle workspaces:")), 0, 16);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "cycle-workspaces-next"), 1, 16);

        var column_end = new Gtk.Grid ();
        column_end.column_spacing = 12;
        column_end.halign = Gtk.Align.START;
        column_end.hexpand = true;
        column_end.orientation = Gtk.Orientation.VERTICAL;
        column_end.row_spacing = 12;

        column_end.add (new Granite.HeaderLabel (_("System")));
        column_end.attach (new NameLabel (_("Applications Menu:")), 0, 1);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "panel-main-menu"), 1, 1);
        column_end.attach (new NameLabel (_("Cycle display mode:")), 0, 2);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MUTTER, "switch-monitor"), 1, 2);
        column_end.attach (new NameLabel (_("Zoom in:")), 0, 3);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "zoom-in"), 1, 3);
        column_end.attach (new NameLabel (_("Zoom out:")), 0, 4);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "zoom-out"), 1, 4);
        column_end.attach (new NameLabel (_("Lock screen:")), 0, 5);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MEDIA, "screensaver"), 1, 5);
        column_end.attach (new NameLabel (_("Log out:")), 0, 6);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MEDIA, "logout"), 1, 6);

        column_end.add (new Granite.HeaderLabel (_("Screenshots")));
        column_end.attach (new NameLabel (_("Grab the whole screen:")), 0, 8);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MEDIA, "screenshot"), 1, 8);
        column_end.attach (new NameLabel (_("Grab the current window:")), 0, 9);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MEDIA, "window-screenshot"), 1, 9);
        column_end.attach (new NameLabel (_("Select an area to grab:")), 0, 10);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_MEDIA, "area-screenshot"), 1, 10);

        var column_size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
        column_size_group.add_widget (column_start);
        column_size_group.add_widget (column_end);

        column_spacing = 48;
        add (column_start);
        add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
        add (column_end);
    }

    private class NameLabel : Gtk.Label {
        public NameLabel (string label) {
            Object (
                label: label
            );
        }

        construct {
            halign = Gtk.Align.END;
            xalign = 1;
        }
    }
}
