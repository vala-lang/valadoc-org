public static int main (string[] args) {
	Gtk.init (ref args);

	Gtk.Assistant assistant = new Gtk.Assistant ();
	assistant.apply.connect (Gtk.main_quit);
	assistant.cancel.connect (Gtk.main_quit);
	assistant.set_default_size (500, 500);

	Gtk.Label label1 = new Gtk.Label ("My first page");
	int page_num = assistant.append_page (label1);
	assistant.set_page_title (label1, "Page %d: My Intro".printf (page_num));
	assistant.set_page_type (label1, Gtk.AssistantPageType.INTRO);
	assistant.set_page_complete (label1, true);

	Gtk.Label label2 = new Gtk.Label ("My second page");
	page_num = assistant.append_page (label2);
	assistant.set_page_title (label2, "Page %d: My Content".printf (page_num));
	assistant.set_page_type (label2, Gtk.AssistantPageType.CONTENT);
	assistant.set_page_complete (label2, true);

	Gtk.Label label3 = new Gtk.Label ("My third page");
	page_num = assistant.append_page (label3);
	assistant.set_page_title (label3, "Page %d: Confirm".printf (page_num));
	assistant.set_page_type (label3, Gtk.AssistantPageType.CONFIRM);
	assistant.set_page_complete (label3, true);

	assistant.show_all ();
	Gtk.main ();
	return 0;
}
