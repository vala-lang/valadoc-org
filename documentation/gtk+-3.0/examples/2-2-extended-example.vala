
// This example differs from the simple example as we sub-class
// Gtk.Window to define our own MyWindow class.
public class MyWindow : Gtk.Window {
	private Gtk.Button button;

	public MyWindow () {
		// In the class’s constructor we have to call the
		// constructor of the super class. In addition, we tell
		// it to set the value of the property title to Hello World.
		Object (title: "Hello World");

		// The next three lines are used to create a button widget,
		// connect to its clicked signal and add it as child to the
		// top-level window.
		this.button = new Gtk.Button.with_label ("Click Here");
		this.button.clicked.connect(this.on_button_clicked);
		this.add (this.button);
	}

	// Accordingly, the method on_button_clicked() will be called
	// if you click on the button.
    private void on_button_clicked () {
		stdout.printf ("Hello World\n");
	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		// The last block is very similar to the simple example above,
		// but instead of creating an instance of the generic Gtk.Window
		// class, we create an instance of MyWindow.
		MyWindow win = new MyWindow ();
		win.destroy.connect (Gtk.main_quit);
		win.show_all ();

		Gtk.main ();
		return 0;
	}
}


