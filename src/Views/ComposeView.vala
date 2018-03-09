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

// Characters to include:
// 
// Typographic Glyphs
//     Em dash
//     En dash
//     Quotes
// Arrows
// Accented characters
// Mathematical
//     Times
//     Division
//     Fractions
//     Exponents

public class ShortcutOverlay.ComposeView : Gtk.Grid {
    private const string SCHEMA_INPUT_SOURCES = "org.gnome.desktop.input-sources";

    construct {
        column_spacing = 24;
        margin = 12;
        margin_bottom = 32;

        var grid = new Gtk.Grid ();
        grid.column_spacing = 12;

        var instructions = new Gtk.Label (_("Tap the <b>Right Alt</b> key, then the keys listed to insert special characters."));
        instructions.use_markup = true;
        instructions.halign = Gtk.Align.CENTER;

        var name_label = new Gtk.Label (_("Em Dash (—):"));
        name_label.halign = Gtk.Align.END;
        name_label.xalign = 1;

        var key_grid = new Gtk.Grid ();
        key_grid.orientation = Gtk.Orientation.HORIZONTAL;
        key_grid.column_spacing = 6;
        
        var key1_label = new Gtk.Label ("-");
        key1_label.get_style_context ().add_class ("keycap");

        var key2_label = new Gtk.Label ("-");
        key2_label.get_style_context ().add_class ("keycap");

        var key3_label = new Gtk.Label ("-");
        key3_label.get_style_context ().add_class ("keycap");

        key_grid.add (key1_label);
        key_grid.add (key2_label);
        key_grid.add (key3_label);

        grid.attach (instructions, 0, 0, 2, 1);
        grid.attach (name_label,   0, 1, 1, 1);
        grid.attach (key_grid,     1, 1, 1, 1);

        add (grid);
    }
}
