public static void shutdown () {
	Process.abort ();
}

public static int main (string[] args) {
	// Output: ``Aborted``
	shutdown ();
	print ("You can't see ne!\n");
	return 0;
}
