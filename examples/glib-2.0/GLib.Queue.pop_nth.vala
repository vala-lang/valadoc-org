public static int main () {
	Queue<int> queue = new Queue<int> ();
	queue.push_tail (1);
	queue.push_tail (2);
	queue.push_tail (3);

	// Output: ``pop: 2; remaining size: 2``
	int i = queue.pop_nth (1);
	print ("pop: %d; remaining size: %u\n", i, queue.get_length ());

	return 0;
}
