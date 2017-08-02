public static int main (string[] args) {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("3");
	queue.push_tail ("4");

	queue.push_nth ("2", 1);

	// Output: ``1 2 3 4``
	string item;
	while ((item = queue.pop_head ()) != null) {
		print ("%s ", item);
	}
	print ("\n");

	return 0;
}
