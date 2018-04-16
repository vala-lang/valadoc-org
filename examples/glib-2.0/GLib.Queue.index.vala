public static int main () {
	Queue<int> queue = new Queue<int> ();
	queue.push_tail (1);
	queue.push_tail (2);
	queue.push_tail (3);

	// Output: ``1``
	uint pos = queue.index (2);
	print ("%u\n", pos);

	return 0;
}
