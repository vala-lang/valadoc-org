public static int main (string[] args) {
	string haystack = "Tell me on the way Brigadier! Tell me on the way!";
	string needle = "Tell me";
	int index = -1;

	// Output: ``0``
	index = haystack.index_of (needle);
	stdout.printf ("%d\n", index);

	// Output: ``30``
	index = haystack.index_of (needle, 5);
	stdout.printf ("%d\n", index);

	// Output: ``-1``
	index = haystack.index_of ("NOT-AVAILABLE", 5);
	stdout.printf ("%d\n", index);

	// Output: ``0 30 -1``
	index = 0;
	do {
		index = haystack.index_of (needle, index);
		stdout.printf ("%d ", index);
	} while (index++ >= 0);
	stdout.putc ('\n');

	return 0;
}
