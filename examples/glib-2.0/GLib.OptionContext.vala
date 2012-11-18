public class Main : Object {
	private static bool version = false;
	private static string? directory = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? importdirs = null;
	private static string? driver = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? import_packages = null;
	private static double numd = 0;
	private static int64 numi64 = 0;
	private static int numi = 0;

	private const GLib.OptionEntry[] options = {
		// --version
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },

		// --directory FIlENAME || -o FILENAME
		{ "directory", 'o', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },
		// [--vapidir FILENAME]*
		{ "importdir", 0, 0, OptionArg.FILENAME_ARRAY, ref importdirs, "Look for external documentation in DIRECTORY", "DIRECTORY..." },

		// --driver
		{ "driver", 0, 0, OptionArg.STRING, ref driver, "Use the given driver", "DRIVER" },
		// [--import STRING]*
		{ "import", 0, 0, OptionArg.STRING_ARRAY, ref import_packages, "Include binding for PACKAGE", "PACKAGE..." },

		// --double DOUBLE
		{ "double", 0, 0, OptionArg.DOUBLE, ref numd, "double value", "DOUBLE" },
		// --int64 INT64
		{ "int64", 0, 0, OptionArg.INT64, ref numi64, "int64 value", "INT64" },
		// --int INT
		{ "int", 0, 0, OptionArg.INT, ref numi, "int value", "INT" },

		// list terminator
		{ null }
	};

	public static int main (string[] args) {
		try {
			var opt_context = new OptionContext ("- OptionContext example");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("error: %s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 0;
		}

		if (version) {
			stdout.printf ("Test 0.1\n");
			return 0;
		}


		stdout.puts ("Paths:\n");
		stdout.printf (" directory: \"%s\"\n", directory);
		stdout.puts (" importdir: ");
		foreach (string str in importdirs) {
			stdout.printf ("\"%s\" ", str);
		}
		stdout.puts ("\n\n");


		stdout.puts ("Strings:\n");
		stdout.printf (" driver: \"%s\"\n", driver);
		stdout.puts (" import: ");
		foreach (string str in import_packages) {
			stdout.printf ("\"%s\" ", str);
		}
		stdout.puts ("\n\n");


		stdout.puts ("Numeric:\n");
		stdout.printf (" double:  %f\n", numd);
		stdout.printf (" int64:   %" + int64.FORMAT + "\n", numi64);
		stdout.printf (" int:     %d\n", numi);
		stdout.printf (" version: %s\n", version.to_string ());

		// Help:
		//  ``Usage:``
		//  ``	test2 [OPTION...] - OptionContext example``
		//  ``
		//  ``	Help Options:``
		//  ``	  -h, --help                    Show help options``
		//  ``
		//  ``	Application Options:``
		//  ``	  --version                     Display version number``
		//  ``	  -o, --directory=DIRECTORY     Output directory``
		//  ``	  --importdir=DIRECTORY...      Look for external documentation in DIRECTORY``
		//  ``	  --driver=DRIVER               Use the given driver``
		//  ``	  --import=PACKAGE...           Include binding for PACKAGE``
		//  ``	  --double=DOUBLE               double value``
		//  ``	  --int64=INT64                 int64 value``
		//  ``	  --int=INT                     int value``

		return 0;
	}
}
