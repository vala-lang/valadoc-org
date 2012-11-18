public static int main (string[] args) {
	Value value1 = Value (typeof (string));
	value1.set_string ("My string");

	// Output: ``My string``
	stdout.printf ("%s\n", value1.get_string ());

	// Output: ``My string``
	stdout.printf ("%s\n", value1.dup_string ());

	// Output: ``My string``
	stdout.printf ("%s\n", (string) value1);

	// Output: ``My string 2``
	value1 = "My string 2";
	stdout.printf ("%s\n", (string) value1);

	return 0;
}
