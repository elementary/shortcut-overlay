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

public class ShortcutOverlay.MainWindow : Gtk.Window {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            resizable: false,
            title: _("Keyboard Shortcuts"),
            width_request: 910
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

        var headerbar = new Gtk.HeaderBar ();
        headerbar.has_subtitle = false;
        headerbar.set_show_close_button (true);
        headerbar.pack_end (settings_button);

        var headerbar_style_context =  headerbar.get_style_context ();
        headerbar_style_context.add_class (Gtk.STYLE_CLASS_FLAT);
        headerbar_style_context.add_class ("default-decoration");

        var shortcuts_view = new ShortcutsView ();
        
        var compose_view = new ComposeView ();

        var stack = new Gtk.Stack ();        
        stack.add_titled (shortcuts_view, "shortcuts", _("Shortcuts"));
        stack.add_titled (compose_view, "compose", _("Compose Key"));

        var stack_switcher = new Gtk.StackSwitcher ();
        stack_switcher.halign = Gtk.Align.CENTER;
        stack_switcher.homogeneous = true;
        stack_switcher.margin = 12;
        stack_switcher.stack = stack;

        var grid = new Gtk.Grid ();
        grid.margin_start = grid.margin_end = 12;
        grid.margin_bottom = 32;
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.add (stack_switcher);
        grid.add (stack);

        add (grid);

        get_style_context ().add_class ("rounded");
        set_titlebar (headerbar);

        settings_button.clicked.connect (() => {
            try {
                AppInfo.launch_default_for_uri ("settings://input/keyboard/shortcuts", null);
            } catch (Error e) {
                warning (e.message);
            }
        });
    }
}
