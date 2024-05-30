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


public class ShortcutLabel : Gtk.Box {
    public string[] accels { get; construct; }

    private static Gee.ArrayList<Settings> settings_list;
    private static Settings get_settings_for_schema (string schema_id) {
        if (settings_list == null) {
            settings_list = new Gee.ArrayList<Settings> ();
        } else if (settings_list.size > 0) {
            foreach (var settings in settings_list) {
                if (settings.schema_id == schema_id) {
                    return settings;
                }
            }
        }

        var settings = new Settings (schema_id);
        settings_list.add (settings);

        return settings;
    }

    public ShortcutLabel (string[] accels ) {
        Object (accels: accels);
    }

    public ShortcutLabel.from_gsettings (string schema_id, string key) {
        var settings = get_settings_for_schema (schema_id);
        var key_value = settings.get_value (key);

        string[] accels = {""};
        if (key_value.is_of_type (VariantType.ARRAY)) {
            var key_value_strv = key_value.get_strv ();
            if (key_value_strv.length > 0 && key_value_strv[0] != "") {
                accels = Granite.accel_to_string (key_value_strv[0]).split (" + ");
            }
        } else {
            accels = Granite.accel_to_string (key_value.dup_string ()).split (" + ");
        }

        Object (accels: accels);
    }

    construct {
        spacing = 6;

        if (accels[0] != "") {
            foreach (unowned string accel in accels) {
                if (accel == "") {
                    continue;
                }
                var label = new Gtk.Label (accel);
                label.add_css_class ("keycap");
                append (label);
            }
        } else {
            var label = new Gtk.Label (_("Disabled"));
            label.add_css_class (Granite.STYLE_CLASS_DIM_LABEL);
            append (label);
        }
    }
}
