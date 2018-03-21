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


public class ShortcutLabel : Gtk.Grid {
    public Gtk.Label name_label { get; private set; }
    public ShortcutEntry entry { get; construct; }

    public ShortcutLabel (ShortcutEntry entry) {
        Object (entry: entry);
    }

    construct {
        orientation = Gtk.Orientation.HORIZONTAL;
        column_spacing = 12;

        name_label = new Gtk.Label (entry.name);
        name_label.halign = Gtk.Align.END;
        name_label.xalign = 1;
        add (name_label);

        var accel_grid = new Gtk.Grid ();
        accel_grid.orientation = Gtk.Orientation.HORIZONTAL;
        accel_grid.column_spacing = 6;

        if (entry.accels[0] != "") {
            foreach (string accel in entry.accels) {
                var label = new Gtk.Label (accel);
                label.get_style_context ().add_class ("keycap");
                accel_grid.add (label);
            }
        } else {
            var label = new Gtk.Label (_("Disabled"));
            label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);
            accel_grid.add (label);
        }

        add (accel_grid);
    }
}
