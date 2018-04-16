public static int main (string[] args) {
	Queue<int> queue = new Queue<int> ();
	queue.push_tail (1);
	queue.push_tail (3);

	unowned List<int> pos = queue.find (3);
	queue.insert_before (pos, 2);

	// Output: ``1 2 3 ``
	int item = 0;
	while ((item = queue.pop_head ()) != 0) {
		print ("%d ", item);
	}
	print ("\n");

	return 0;
}
