public static void shutdown () {
	Process.exit (0);
}

public static int main (string[] args) {
	// Output: ````
	shutdown ();
	stdout.printf ("You can't see me!\n");
	return 0;
}
