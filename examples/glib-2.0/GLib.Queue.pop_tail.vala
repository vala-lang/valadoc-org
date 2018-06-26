public static int main () {
	Queue<string> stack = new Queue<string> ();
	stack.push_tail ("1");
	stack.push_tail ("2");
	stack.push_tail ("3");

	// Output: ``3 2 1 ``
	string item = null;
	while ((item = stack.pop_tail ()) != null) {
		print ("%s ", item);
	}
	print ("\n");

	return 0;
}
