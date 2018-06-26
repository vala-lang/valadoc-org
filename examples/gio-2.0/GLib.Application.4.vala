public class MyApplication : Application {
	private int counter = 0;

	private MyApplication () {
		Object (application_id: "org.example.application", flags: ApplicationFlags.HANDLES_COMMAND_LINE);
		set_inactivity_timeout (10000);
	}

	public override void activate () {
		this.hold ();
		print ("Activated\n");
		this.release ();
	}


	private int _command_line (ApplicationCommandLine command_line) {
		bool version = false;
		bool count = false;

		OptionEntry[] options = new OptionEntry[2];
		options[0] = { "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null };
		options[1] = { "count", 0, 0, OptionArg.NONE, ref count, "Display version number", null };


		// We have to make an extra copy of the array, since .parse assumes
		// that it can remove strings from the array without freeing them.
		string[] args = command_line.get_arguments ();
		string*[] _args = new string[args.length];
		for (int i = 0; i < args.length; i++) {
			_args[i] = args[i];
		}

		try {
			var opt_context = new OptionContext ("- OptionContext example");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			unowned string[] tmp = _args;
			opt_context.parse (ref tmp);
		} catch (OptionError e) {
			command_line.print ("error: %s\n", e.message);
			command_line.print ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 0;
		}

		if (version) {
			command_line.print ("Test 0.1\n");
			return 0;
		}

		if (count) {
			command_line.print ("%d\n", ++this.counter);
			return 0;
		}


		return 0;
	}

	public override int command_line (ApplicationCommandLine command_line) {
		// keep the application running until we are done with this commandline
		this.hold ();
		int res = _command_line (command_line);
		this.release ();
		return res;
	}

	public static int main (string[] args) {
		MyApplication app = new MyApplication ();
		int status = app.run (args);
		return status;
	}
}
