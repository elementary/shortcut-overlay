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
    private const string SCHEMA_GALA = "io.elementary.desktop.wm.keybindings";
    private const string SCHEMA_MEDIA = "org.gnome.settings-daemon.plugins.media-keys";
    private const string SCHEMA_MUTTER = "org.gnome.mutter.keybindings";

    construct {
        var windows_grid = new Gtk.Grid () {
            column_spacing = 12,
            hexpand = true,
            row_spacing = 12
        };

        var windows_header = new Granite.HeaderLabel (_("Windows")) {
            mnemonic_widget = windows_grid
        };

        var windows_box = new Gtk.Box (VERTICAL, 0);
        windows_box.append (windows_header);
        windows_box.append (windows_grid);

        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Close window:"), SCHEMA_WM, "close"), 0, 1);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Cycle windows:"), SCHEMA_WM, "switch-windows"), 0, 2);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Toggle maximized:"), SCHEMA_WM, "toggle-maximized"), 0, 3);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Tile left:"), SCHEMA_MUTTER, "toggle-tiled-left"), 0, 4);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Tile right:"), SCHEMA_MUTTER, "toggle-tiled-right"), 0, 5);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Move to left workspace:"), SCHEMA_WM, "move-to-workspace-left"), 0, 6);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Move to right workspace:"), SCHEMA_WM, "move-to-workspace-right"), 0, 7);
        windows_grid.attach (new ShortcutLabel.from_gsettings (_("Picture in Picture Mode:"), SCHEMA_GALA, "pip"), 0, 8);

        var workspaces_grid = new Gtk.Grid () {
            column_spacing = 12,
            hexpand = true,
            row_spacing = 12
        };

        var workspaces_header = new Granite.HeaderLabel (_("Workspaces")) {
            mnemonic_widget = workspaces_grid
        };

        var workspaces_box = new Gtk.Box (VERTICAL, 0);
        workspaces_box.append (workspaces_header);
        workspaces_box.append (workspaces_grid);

        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Multitasking View:"), SCHEMA_GALA, "toggle-multitasking-view"), 0, 10);
        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Switch left:"), SCHEMA_WM, "switch-to-workspace-left"), 0, 11);
        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Switch right:"), SCHEMA_WM, "switch-to-workspace-right"), 0, 12);
        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Switch to first:"), SCHEMA_GALA, "switch-to-workspace-first"), 0, 13);
        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Switch to new:"), SCHEMA_GALA, "switch-to-workspace-last"), 0, 14);
        workspaces_grid.attach (new ShortcutLabel.from_gsettings (_("Cycle workspaces:"), SCHEMA_GALA, "cycle-workspaces-next"), 0, 15);

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

        var system_grid = new Gtk.Grid () {
            column_spacing = 12,
            hexpand = true,
            row_spacing = 12
        };

        var system_header = new Granite.HeaderLabel (_("System")) {
            mnemonic_widget = system_grid
        };

        var system_box = new Gtk.Box (VERTICAL, 0);
        system_box.append (system_header);
        system_box.append (system_grid);

        system_grid.attach (new ShortcutLabel.from_gsettings (_("Applications Menu:"), SCHEMA_GALA, "panel-main-menu"), 0, 1);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Cycle display mode:"), SCHEMA_MUTTER, "switch-monitor"), 0, 2);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Zoom in:"), SCHEMA_GALA, "zoom-in"), 0, 3);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Zoom out:"), SCHEMA_GALA, "zoom-out"), 0, 4);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Lock screen:"), SCHEMA_MEDIA, "screensaver"), 0, 5);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Log out:"), SCHEMA_MEDIA, "logout"), 0, 6);
        system_grid.attach (new ShortcutLabel (_("Switch keyboard layout:"), xkb_input_accels), 0, 7);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Toggle on-screen keyboard:"), SCHEMA_MEDIA, "on-screen-keyboard"), 0, 8);
        system_grid.attach (new ShortcutLabel.from_gsettings (_("Toggle screen reader:"), SCHEMA_MEDIA, "screenreader"), 0, 9);

        var screenshots_grid = new Gtk.Grid () {
            column_spacing = 12,
            hexpand = true,
            row_spacing = 12
        };

        var screenshots_header = new Granite.HeaderLabel (_("Screenshots")) {
            mnemonic_widget = screenshots_grid
        };

        var screenshots_box = new Gtk.Box (VERTICAL, 0);
        screenshots_box.append (screenshots_header);
        screenshots_box.append (screenshots_grid);

        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Grab the whole screen:"), SCHEMA_GALA, "screenshot"), 0, 11);
        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Copy the whole screen to clipboard:"), SCHEMA_GALA, "screenshot-clip"), 0, 12);
        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Grab the current window:"), SCHEMA_GALA, "window-screenshot"), 0, 13);
        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Copy the current window to clipboard:"), SCHEMA_GALA, "window-screenshot-clip"), 0, 14);
        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Select an area to grab:"), SCHEMA_GALA, "area-screenshot"), 0, 15);
        screenshots_grid.attach (new ShortcutLabel.from_gsettings (_("Copy an area to clipboard:"), SCHEMA_GALA, "area-screenshot-clip"), 0, 16);

        var column_start = new Gtk.Box (VERTICAL, 24);
        column_start.append (windows_box);
        column_start.append (workspaces_box);

        var column_end = new Gtk.Box (VERTICAL, 24);
        column_end.append (system_box);
        column_end.append (screenshots_box);

        spacing = 48;
        append (column_start);
        append (new Gtk.Separator (Gtk.Orientation.VERTICAL));
        append (column_end);
    }
}
