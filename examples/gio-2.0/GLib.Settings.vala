public static int main (string[] args) {
	try {
		// Custom location:
		string settings_dir = Path.get_dirname (args[0]);
		SettingsSchemaSource sss = new SettingsSchemaSource.from_directory (settings_dir, null, false);
		SettingsSchema schema = sss.lookup ("org.example.glib-settings-schema-source", false);
		if (sss.lookup == null) {
			print ("ID not found.");
			return 0;
		}

		Settings settings = new Settings.full (schema, null, null);

		// Default location: (XDG_DATA_DIRS)
		// Settings settings = new Settings ("org.example.glib-settings-schema-source");



		// Output: ``Hello, earthlings``
		string greeting = settings.get_string ("greeting");
		print ("%s\n", greeting);

		// Output: ``99``
		int bottles = settings.get_int ("bottles-of-beer");
		print ("%d\n", bottles);

		// Output: ``false``
		bool lighting = settings.get_boolean ("lighting");
		print ("%s\n", lighting.to_string ());



		// Change notification for any key in the schema
		settings.changed.connect ((key) => {
			print ("Key '%s' changed\n", key);
		});

		// Change notification for a single key
		settings.changed["greeting"].connect (() => {
			print ("New greeting: %s\n", settings.get_string ("greeting"));
		});


		// Setting keys

		// Output:
		//  ``Key 'bottles-of-beer' changed``
		//  ``Key 'lighting' changed``
		//  ``Key 'greeting' changed``
		//  ``New greeting: hello, world``
		settings.set_int ("bottles-of-beer", bottles - 1);
		settings.set_boolean ("lighting", !lighting);
		settings.set_string ("greeting", "hello, world");


		print ("\nPlease start 'dconf-editor' and edit keys in /org/example/my-app/\n");
		new MainLoop ().run ();
	} catch (Error e) {
		print ("Error: %s\n", e.message);
	}
	return 0;
}
