public static int main () {
	Queue<int> queue = new Queue<int> ();
	queue.push_tail (1);
	queue.push_tail (2);
	queue.push_tail (3);

	Queue<int> copy = queue.copy ();

	// Output: ``Queue: 1 2 3 ``
	print ("Queue: ");
	int item = 0;
	while ((item = queue.pop_head ()) != 0) {
		print (@"$item ");
	}
	print ("\n");

	// Output: ``Stats: queue: 0, copy: 3``
	print ("Stats: queue: %u, copy: %u\n", queue.get_length (), copy.get_length ());

	// Output: ``copy: 1 2 3 ``
	print ("Copy: ");
	while ((item = copy.pop_head ()) != 0) {
		print (@"$item ");
	}
	print ("\n");

	// Output: ``Stats: queue: 0, copy: 0``
	print ("Stats: queue: %u, copy: %u\n", queue.get_length (), copy.get_length ());

	return 0;
}
