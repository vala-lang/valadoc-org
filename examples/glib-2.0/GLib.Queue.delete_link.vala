public static int main () {
	Queue<int> queue = new Queue<int> ();
	queue.push_tail (1);
	queue.push_tail (2);
	queue.push_tail (900);
	queue.push_tail (3);

	unowned List<int> found = queue.find (900);
	print ("Found: %d\n", found.data);
	queue.delete_link (found);

	// Output: ``1 2 3 ``
	int item = 0;
	while ((item = queue.pop_head ()) != 0) {
		print ("%d ", item);
	}
	print ("\n");

	return 0;
}
