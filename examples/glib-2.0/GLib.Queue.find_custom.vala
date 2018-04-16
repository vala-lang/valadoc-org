public static int main () {
	Queue<string> queue = new Queue<string> ();
	queue.push_tail ("1");
	queue.push_tail ("2");
	queue.push_tail ("900");
	queue.push_tail ("3");

	unowned List<string> found = queue.find_custom ("900", strcmp);
	print ("Found: %s\n", found.data);
	queue.delete_link (found);

	// Output: ``1 2 3 ``
	string item;
	while ((item = queue.pop_head ()) != null) {
		print ("%s\n", item);
	}

	return 0;
}
