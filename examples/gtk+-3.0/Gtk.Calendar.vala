public class Application : Gtk.Window {
	private Gtk.Calendar calendar;

	private void print_date (string context) {
		print ("%s: %04d-%02d-%02d\n", context, calendar.year, calendar.month, calendar.day);
	}

	public Application () {
		// Prepare Gtk.Window:
		this.title = "My Gtk.Calendar";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 70);

		// Create a new calendar, with the current date being selected:
		this.calendar = new Gtk.Calendar ();
		this.add (this.calendar);

		// Select another date: January 1st, 1970
		this.calendar.year = 1970;
		this.calendar.month = 1;
		this.calendar.day = 1;

		// Place a visual marker on a particular day:
		this.calendar.mark_day (1);

		// Connect signals:
		this.calendar.day_selected.connect (() => {
			this.print_date ("day-selected");
		});

		this.calendar.day_selected_double_click.connect (() => {
			this.print_date ("day-selected-double-click");
		});

		this.calendar.month_changed.connect (() => {
			this.print_date ("month-changed");
		});

		this.calendar.next_month.connect (() => {
			this.print_date ("next-month");
		});

		this.calendar.next_year.connect (() => {
			this.print_date ("next-year");
		});

		this.calendar.prev_month.connect (() => {
			this.print_date ("prev-month");
		});

		this.calendar.prev_year.connect (() => {
			this.print_date ("prev-year");
		});
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
