public class SearchDialog : Gtk.Dialog {
	private Gtk.Entry search_entry;
	private Gtk.CheckButton match_case;
	private Gtk.CheckButton find_backwards;
	private Gtk.Widget find_button;

	public signal void find_next (string text, bool case_sensitivity);
	public signal void find_previous (string text, bool case_sensitivity);

	public SearchDialog () {
		this.title = "Find";
		this.border_width = 5;
		set_default_size (350, 100);
		create_widgets ();
		connect_signals ();
	}

	private void create_widgets () {
		// Create and setup widgets
		this.search_entry = new Gtk.Entry ();
		Gtk.Label search_label = new Gtk.Label.with_mnemonic ("_Search for:");
		search_label.mnemonic_widget = this.search_entry;
		this.match_case = new Gtk.CheckButton.with_mnemonic ("_Match case");
		this.find_backwards = new Gtk.CheckButton.with_mnemonic ("Find _backwards");

		// Layout widgets
		Gtk.Box hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 20);
		hbox.pack_start (search_label, false, true, 0);
		hbox.pack_start (this.search_entry, true, true, 0);

		Gtk.Box content = get_content_area () as Gtk.Box;
		content.pack_start (hbox, false, true, 0);
		content.pack_start (this.match_case, false, true, 0);
		content.pack_start (this.find_backwards, false, true, 0);
		content.spacing = 10;

		// Add buttons to button area at the bottom
		add_button ("_Help", Gtk.ResponseType.HELP);
		add_button ("_Close", Gtk.ResponseType.CLOSE);
		this.find_button = add_button ("_Find", Gtk.ResponseType.APPLY);
		this.find_button.sensitive = false;
	}

	private void connect_signals () {
		this.search_entry.changed.connect (() => {
			this.find_button.sensitive = (this.search_entry.text != "");
		});
		this.response.connect (on_response);
	}

	private void on_response (Gtk.Dialog source, int response_id) {
		switch (response_id) {
		case Gtk.ResponseType.HELP:
			// show_help ();
			break;
		case Gtk.ResponseType.APPLY:
			on_find_clicked ();
			break;
		case Gtk.ResponseType.CLOSE:
			destroy ();
			break;
		}
	}

	private void on_find_clicked () {
		string text = this.search_entry.text;
		bool cs = this.match_case.active;
		if (this.find_backwards.active) {
			find_previous (text, cs);
		} else {
			find_next (text, cs);
		}
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		SearchDialog dialog = new SearchDialog ();
		dialog.destroy.connect (Gtk.main_quit);
		dialog.show_all ();

		Gtk.main ();
		return 0;
	}
}
