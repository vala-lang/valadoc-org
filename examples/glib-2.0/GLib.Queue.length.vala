public static int main () {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("2");
	queue.push_tail ("3");

	// Output:
	//  ``1 (len: 2)``
	//  ``2 (len: 1)``
	//  ``3 (len: 0)``
	string item = null;
	while ((item = queue.pop_head ()) != null) {
		print ("%s (len: %u)\n", item, queue.length);
	}

	return 0;
}
