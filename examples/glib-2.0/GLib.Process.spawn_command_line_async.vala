public static int main (string[] args) {
	try {
		Process.spawn_command_line_async ("mkdir MY-NEW-DIR");
	} catch (SpawnError e) {
		stdout.printf ("Error: %s\n", e.message);
	}
	return 0;
}
