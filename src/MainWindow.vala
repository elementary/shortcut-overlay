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

public class ShortcutOverlay.MainWindow : Gtk.Window {
    private static Gee.ArrayList<ShortcutEntry> application_entries;
    private static Gee.ArrayList<ShortcutEntry> window_entries;
    private static Gee.ArrayList<ShortcutEntry> workspace_entries;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 640,
            resizable: false,
            title: _("Keyboard Shortcuts"),
            width_request: 910
        );
    }

    static construct {
        application_entries = new Gee.ArrayList<ShortcutEntry> ();
        application_entries.add (new ShortcutEntry (_("Applications Menu:"), "org.gnome.desktop.wm.keybindings", "panel-main-menu")); 

        window_entries = new Gee.ArrayList<ShortcutEntry> ();
        window_entries.add (new ShortcutEntry (_("Switch windows:"), "org.gnome.desktop.wm.keybindings", "switch-windows"));   

        workspace_entries = new Gee.ArrayList<ShortcutEntry> (); 
        workspace_entries.add (new ShortcutEntry (_("Multitasking View:"), "org.gnome.desktop.wm.keybindings", "show-desktop"));
        workspace_entries.add (new ShortcutEntry (_("Switch workspaces:"), "org.pantheon.desktop.gala.keybindings", "cycle-workspaces-next"));           
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

        var layout = new Gtk.Grid ();
        layout.orientation = Gtk.Orientation.VERTICAL;
        layout.column_spacing = 6;
        layout.row_spacing = 12;
        layout.hexpand = true;
        layout.margin = 12;

        var size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);

        var window_header = new Granite.HeaderLabel (_("Windows"));
        layout.add (window_header);

        foreach (var entry in window_entries) {
            var label = new ShortcutLabel (entry);

            layout.add (label);

            size_group.add_widget (label.name_label);
        }

        var workspace_header = new Granite.HeaderLabel (_("Workspaces"));
        layout.add (workspace_header);

        foreach (var entry in workspace_entries) {
            var label = new ShortcutLabel (entry);

            layout.add (label);

            size_group.add_widget (label.name_label);
        }

        var application_header = new Granite.HeaderLabel (_("Applications"));
        layout.add (application_header);

        foreach (var entry in application_entries) {
            var label = new ShortcutLabel (entry);

            layout.add (label);

            size_group.add_widget (label.name_label);
        }

        add (layout);
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
