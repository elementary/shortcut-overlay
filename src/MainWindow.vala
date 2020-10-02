/*-
 * Copyright (c) 2017–2018 elementary LLC. (https://elementary.io)
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

public class ShortcutOverlay.MainWindow : Hdy.Window {
    public bool can_destroy { get; set; default = false; }

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            resizable: false,
            title: _("Keyboard Shortcuts")
        );
    }

    construct {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("io/elementary/shortcut-overlay/application.css");
        Gtk.StyleContext.add_provider_for_screen (get_screen (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        var settings_button = new Gtk.Button.from_icon_name ("preferences-system-symbolic", Gtk.IconSize.MENU);
        settings_button.tooltip_text = _("Keyboard Settings…");
        settings_button.valign = Gtk.Align.CENTER;
        settings_button.get_style_context ().add_class ("titlebutton");

        var headerbar = new Gtk.HeaderBar () {
            title = _("Keyboard Shortcuts"),
            has_subtitle = false
        };
        headerbar.set_show_close_button (true);
        headerbar.pack_end (settings_button);

        var shortcuts_view = new ShortcutsView ();
        shortcuts_view.margin = 36;
        shortcuts_view.margin_top = 12;

        var grid = new Gtk.Grid ();
        grid.attach (headerbar, 0, 0);
        grid.attach (shortcuts_view, 0, 1);

        skip_taskbar_hint = true;
        add (grid);

        settings_button.clicked.connect (() => {
            try {
                AppInfo.launch_default_for_uri ("settings://input/keyboard/shortcuts", null);
            } catch (Error e) {
                warning (e.message);
            }
        });
    }
}
