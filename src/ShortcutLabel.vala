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
    public string[] accels { get; construct; }

    public ShortcutLabel (string[] accels ) {
        Object (accels: accels);
    }

    construct {
        column_spacing = 6;

        if (accels[0] != "") {
            foreach (unowned string accel in accels) {
                var label = new Gtk.Label (accel);
                label.get_style_context ().add_class ("keycap");
                add (label);
            }
        } else {
            var label = new Gtk.Label (_("Disabled"));
            label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);
            add (label);
        }
    }
}
