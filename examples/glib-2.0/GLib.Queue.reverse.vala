public static int main () {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("2");
	queue.push_tail ("3");
	queue.reverse ();

	// Output: ``3 2 1 ``
	string item = null;
	while ((item = queue.pop_head ()) != null) {
		print ("%s ", item);
	}
	print ("\n");
	return 0;
}
