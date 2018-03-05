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

public class ShortcutEntry : Object {
    public string name { get; construct; }
    public string[] accels { get; private set; }

    private static Gee.ArrayList<Settings> settings_list;
    private static Settings get_settings_for_schema (string schema_id) {
        foreach (var settings in settings_list) {
            if (settings.schema_id == schema_id) {
                return settings;
            }
        }

        var settings = new Settings (schema_id);
        settings_list.add (settings);

        return settings;
    }

    static construct {
        settings_list = new Gee.ArrayList<Settings> ();
    }

    public ShortcutEntry (string name, string schema_id, string key) {
        Object (name: name);

        var settings = get_settings_for_schema (schema_id);
        var key_value = settings.get_value (key);

        if (key_value.is_of_type (VariantType.ARRAY)) {
            string[] accels = key_value.get_strv ();
            if (accels.length > 0) {
                parse_accelerator (accels[0]);
            }
        } else {
            parse_accelerator (key_value.dup_string ());
        }
    }

    private void parse_accelerator (string accel) {
        uint accel_key;
        Gdk.ModifierType accel_mods;
        Gtk.accelerator_parse (accel, out accel_key, out accel_mods);

        string[] arr = {};
        if (Gdk.ModifierType.SUPER_MASK in accel_mods) {
            arr += _("⌘");
        }

        if (Gdk.ModifierType.SHIFT_MASK in accel_mods) {
            arr += _("Shift");
        }

        if (Gdk.ModifierType.CONTROL_MASK in accel_mods) {
            arr += _("Ctrl");
        }

        if (Gdk.ModifierType.MOD1_MASK in accel_mods) {
            arr += _("Alt");
        }

        switch (accel_key) {
            case Gdk.Key.Up:
                arr += "↑";
                break;
            case Gdk.Key.Down:
                arr += "↓";
                break;
            case Gdk.Key.Left:
                arr += "←";
                break;
            case Gdk.Key.Right:
                arr += "→";
                break;
            default:
                arr += Gtk.accelerator_get_label (accel_key, 0);
                break;
        }

        accels = arr;
    }
}
