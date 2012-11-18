public static int main (string[] args) {
	GLib.File file = GLib.File.new_for_commandline_arg (args[1]);
	try {
		file.replace_contents (args[0].data, null, true, GLib.FileCreateFlags.NONE, null, null);
	} catch ( GLib.Error e ) {
		GLib.error (e.message);
	}

	return 0;
}
