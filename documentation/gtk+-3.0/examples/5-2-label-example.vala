



public class LabelWindow : Gtk.Window {
	private Gtk.Box hbox;
	private Gtk.Box vbox_left;
	private Gtk.Box vbox_right;

    public LabelWindow () {
        Object (title: "Label Example");
        
        this.hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

        this.hbox.set_homogeneous (false);
        this.vbox_left = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        this.vbox_left.set_homogeneous (false);
        this.vbox_right = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        this.vbox_right.set_homogeneous (false);
        
        this.hbox.pack_start (vbox_left, true, true, 0);
        this.hbox.pack_start (vbox_right, true, true, 0);
        
        var label = new Gtk.Label ("This is a normal label");
        this.vbox_left.pack_start (label, true, true, 0);
        
        label = new Gtk.Label ("");
        label.set_text ("This is a left-justified label.\nWith multiple lines.");
        label.set_justify (Gtk.Justification.LEFT);
        this.vbox_left.pack_start (label, true, true, 0);
        
        label = new Gtk.Label ("This is a right-justified label.\nWith multiple lines.");
        label.set_justify (Gtk.Justification.RIGHT);
        this.vbox_left.pack_start (label, true, true, 0);
        
        label = new Gtk.Label ("This is an example of a line-wrapped label.  It " +
                               "should not be taking up the entire             " +
                               "width allocated to it, but automatically " +
                               "wraps the words to fit.\n" +
                               "     It supports multiple paragraphs correctly, " +
                               "and  correctly   adds " +
                               "many          extra  spaces. ");
        label.set_line_wrap (true);
        this.vbox_right.pack_start (label, true, true, 0);
        
        label = new Gtk.Label ("This is an example of a line-wrapped, filled label.  " +
                               "It should be taking " +
                               "up the entire              width allocated to it.  " +
                               "Here is a sentence to prove " +
                               "my point.  Here is another sentence. " +
                               "Here comes the sun, do de do de do.\n" +
                               "    This is a new paragraph.\n" +
                               "    This is another newer, longer, better " +
                               "paragraph.  It is coming to an end, " +
                               "unfortunately.");
        label.set_line_wrap (true);
        label.set_justify (Gtk.Justification.FILL);
        this.vbox_right.pack_start (label, true, true, 0);

        label = new Gtk.Label ("");
        label.set_markup ("Text can be <small>small</small>, <big>big</big>, " +
                          "<b>bold</b>, <i>italic</i> and even point to somewhere " +
                          "in the <a href=\"http://www.gtk.org\" " +
                          "title=\"Click to find out more\">internets</a>.");
        label.set_line_wrap (true);
        this.vbox_left.pack_start (label, true, true, 0);

        label = new Gtk.Label.with_mnemonic ("_Press Alt + P to select button to the right");
        this.vbox_left.pack_start (label, true, true, 0);
        label.set_selectable (true);

        var button = new Gtk.Button.with_label ("Click at your own risk");
        label.set_mnemonic_widget (button);
        this.vbox_right.pack_start (button, true, true, 0);

        this.add (hbox);
	}


	public static int main (string[] args) {
		Gtk.init (ref args);

		var window = new LabelWindow ();
		window.destroy.connect (Gtk.main_quit);
		window.show_all ();

		Gtk.main ();
		return 0;
	}
}

