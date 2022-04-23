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

public class ShortcutOverlay.ShortcutsView : Gtk.Box {
    private const string SCHEMA_WM = "org.gnome.desktop.wm.keybindings";
    private const string SCHEMA_GALA = "org.pantheon.desktop.gala.keybindings";
    private const string SCHEMA_MEDIA = "org.gnome.settings-daemon.plugins.media-keys";
    private const string SCHEMA_MUTTER = "org.gnome.mutter.keybindings";

    construct {
        var column_start = new Gtk.Grid () {
            column_spacing = 12,
            hexpand = true,
            row_spacing = 12
        };

        var windows_header = new Gtk.Label (_("Windows")) {
            xalign = 0
        };
        windows_header.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        column_start.attach (windows_header, 0, 0, 2);
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

        var workspaces_header = new Gtk.Label (_("Workspaces")) {
            xalign = 0
        };
        workspaces_header.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        column_start.attach (workspaces_header, 0, 9, 2);
        column_start.attach (new NameLabel (_("Multitasking View:")), 0, 10);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "show-desktop"), 1, 10);
        column_start.attach (new NameLabel (_("Switch left:")), 0, 11);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "switch-to-workspace-left"), 1, 11);
        column_start.attach (new NameLabel (_("Switch right:")), 0, 12);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_WM, "switch-to-workspace-right"), 1, 12);
        column_start.attach (new NameLabel (_("Switch to first:")), 0, 13);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "switch-to-workspace-first"), 1, 13);
        column_start.attach (new NameLabel (_("Switch to new:")), 0, 14);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "switch-to-workspace-last"), 1, 14);
        column_start.attach (new NameLabel (_("Cycle workspaces:")), 0, 15);
        column_start.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "cycle-workspaces-next"), 1, 15);

        var input_settings = new GLib.Settings ("org.gnome.desktop.input-sources");
        var xkb_options = input_settings.get_strv ("xkb-options");

        string[] xkb_input_accels = {""};
        foreach (unowned string xkb_command in xkb_options) {
            switch (xkb_command) {
                case "grp:alt_caps_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Alt>Caps_Lock").split (" + ");
                    break;
                case "grp:alt_shift_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Alt><Shift>").split (" + ");
                    break;
                case "grp:alt_space_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Alt>space").split (" + ");
                    break;
                case "grp:shifts_toggle":
                    xkb_input_accels = {
                        Granite.accel_to_string ("Shift_L"),
                        Granite.accel_to_string ("Shift_R")
                    };
                    break;
                case "grp:caps_toggle":
                    xkb_input_accels = {Gtk.accelerator_get_label (Gdk.Key.Caps_Lock, 0)};
                    break;
                case "grp:ctrl_alt_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Ctrl><Alt>").split (" + ");
                    break;
                case "grp:ctrl_shift_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Ctrl><Shift>").split (" + ");
                    break;
                case "grp:shift_caps_toggle":
                    xkb_input_accels = Granite.accel_to_string ("<Shift>Caps_Lock").split (" + ");
                    break;
            }

            if (xkb_input_accels[0] != "") {
                break;
            }
        }

        var column_end = new Gtk.Grid ();
        column_end.column_spacing = 12;
        column_end.hexpand = true;
        column_end.row_spacing = 12;

        var system_header = new Gtk.Label (_("System")) {
            xalign = 0
        };
        system_header.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        column_end.attach (system_header, 0, 0, 2);
        column_end.attach (new NameLabel (_("Applications Menu:")), 0, 1);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "panel-main-menu"), 1, 1);
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
        column_end.attach (new NameLabel (_("Switch keyboard layout:")), 0, 7);
        column_end.attach (new ShortcutLabel (xkb_input_accels), 1, 7);

        var screenshots_header = new Gtk.Label (_("Screenshots")) {
            xalign = 0
        };
        screenshots_header.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        column_end.attach (screenshots_header , 0, 8, 2);
        column_end.attach (new NameLabel (_("Grab the whole screen:")), 0, 9);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "screenshot"), 1, 9);
        column_end.attach (new NameLabel (_("Copy the whole screen to clipboard:")), 0, 10);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "screenshot-clip"), 1, 10);
        column_end.attach (new NameLabel (_("Grab the current window:")), 0, 11);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "window-screenshot"), 1, 11);
        column_end.attach (new NameLabel (_("Copy the current window to clipboard:")), 0, 12);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "window-screenshot-clip"), 1, 12);
        column_end.attach (new NameLabel (_("Select an area to grab:")), 0, 13);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "area-screenshot"), 1, 13);
        column_end.attach (new NameLabel (_("Copy an area to clipboard:")), 0, 14);
        column_end.attach (new ShortcutLabel.from_gsettings (SCHEMA_GALA, "area-screenshot-clip"), 1, 14);

        var column_size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
        column_size_group.add_widget (column_start);
        column_size_group.add_widget (column_end);

        spacing = 48;
        append (column_start);
        append (new Gtk.Separator (Gtk.Orientation.VERTICAL));
        append (column_end);
    }

    private class NameLabel : Gtk.Box {
        public string label { get; construct; }

        public NameLabel (string label) {
            Object (label: label);
        }

        construct {
            var label = new Gtk.Label (label);

            halign = Gtk.Align.END;
            append (label);
        }
    }
}
