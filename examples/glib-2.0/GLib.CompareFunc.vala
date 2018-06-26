public static int main (string[] args) {
	// ** Strings:
	CompareFunc<string> strcmp = GLib.strcmp;

	int res1 = strcmp ("AAA", "BBB");
	int res2 = strcmp ("AAA", "AAA");
	int res3 = strcmp ("BBB", "AAA");
	// Output: ``-1, 0, 1``
	print ("%d, %d, %d\n", res1, res2, res3);

	// ** Integers:
	CompareFunc<int> intcmp = (a, b) => {
		return (int) (a > b) - (int) (a < b);
	};

	res1 = intcmp (1, 2);
	res2 = intcmp (1, 1);
	res3 = intcmp (2, 1);
	// Output: ``-1, 0, 1``
	print ("%d, %d, %d\n", res1, res2, res3);

	return 0;
}
