public static int main () {
	Queue<string> queue = new Queue<string> ();
	bool asc = true;
	CompareDataFunc<string> cmpfunc = (a, b) => {
		return (asc)? strcmp (a, b) : strcmp (b, a);
	};

	queue.insert_sorted ("2", cmpfunc);
	queue.insert_sorted ("1", cmpfunc);
	queue.insert_sorted ("3", cmpfunc);

	// Output: ``1 2 3 ``
	string item = null;
	while ((item = queue.pop_head ()) != null) {
		print ("%s ", item);
	}
	print ("\n");

	return 0;
}
