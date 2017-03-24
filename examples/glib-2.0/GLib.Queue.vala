public static int main () {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("2");
	queue.push_tail ("3");

	// Output: ``1 2 3 ``
	string item = null;
	while ((item = queue.pop_head ()) != null) {
		print ("%s ", item);
	}
	print ("\n");

	Queue<string> stack = new Queue<string> ();
	stack.push_head ("1");
	stack.push_head ("2");
	stack.push_head ("3");

	// Output: ``3 2 1 ``
	while ((item = stack.pop_head ()) != null) {
		print ("%s ", item);
	}
	print ("\n");

	return 0;
}
