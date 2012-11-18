public static int main () {
	Queue<string> queue = new Queue<string> ();
	// Output: ``true``
	stdout.printf ("%s\n", queue.is_empty ().to_string ());
	queue.push_tail ("1");
	// Output: ``false``
	stdout.printf ("%s\n", queue.is_empty ().to_string ());
	queue.push_tail ("2");
	// Output: ``false``
	stdout.printf ("%s\n", queue.is_empty ().to_string ());


	// Output: ``false``
	queue.pop_tail ();
	stdout.printf ("%s\n", queue.is_empty ().to_string ());
	// Output: ``true``
	queue.pop_tail ();
	stdout.printf ("%s\n", queue.is_empty ().to_string ());

	return 0;
}
