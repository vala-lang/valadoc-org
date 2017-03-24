public static int main () {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("2");
	queue.push_tail ("3");

	// Output: ``3``
	print ("%u\n", queue.get_length ());

	// Output: ``0``
	queue.clear ();
	print ("%u\n", queue.get_length ());

	return 0;
}
