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
    public string[] accels { get; private set; }
    public string key { get; construct; }
    public string name { get; construct; }
    public string schema_id { get; construct; }

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

    public ShortcutEntry (string name, string schema_id, string key) {
        Object (
            key: key,
            name: name,
            schema_id: schema_id
        );
    }

    static construct {
        settings_list = new Gee.ArrayList<Settings> ();
    }

    construct {
        var settings = get_settings_for_schema (schema_id);
        var key_value = settings.get_value (key);

        accels = {""};
        if (key_value.is_of_type (VariantType.ARRAY)) {
            var key_value_strv = key_value.get_strv ();
            if (key_value_strv.length > 0) {
                accels = Granite.accel_to_string (key_value_strv[0]).split (" + ");
            }
        } else {
            accels = Granite.accel_to_string (key_value.dup_string ()).split (" + ");
        }
    }
}
