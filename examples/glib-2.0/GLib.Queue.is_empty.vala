public static int main () {
	Queue<string> queue = new Queue<string> ();
	// Output: ``true``
	print ("%s\n", queue.is_empty ().to_string ());
	queue.push_tail ("1");
	// Output: ``false``
	print ("%s\n", queue.is_empty ().to_string ());
	queue.push_tail ("2");
	// Output: ``false``
	print ("%s\n", queue.is_empty ().to_string ());


	// Output: ``false``
	queue.pop_tail ();
	print ("%s\n", queue.is_empty ().to_string ());
	// Output: ``true``
	queue.pop_tail ();
	print ("%s\n", queue.is_empty ().to_string ());

	return 0;
}
