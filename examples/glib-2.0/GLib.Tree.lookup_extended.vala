public static int main (string[] args) {
	Tree<string, string> tree = new Tree<string, string> ((a,b) => { return strcmp (a,b); });
	tree.insert ("1. entry", "1. entry");
	tree.insert ("2. entry", "2. entry");
	tree.insert ("3. entry", "3. entry");

	string needle = "1. entry";
	unowned string? key = null; // stored key
	unowned string? val = null; // stored value
	bool res = tree.lookup_extended (needle, out key, out val);
	// Output: ``res='true' needle='1. entry' key='1. entry', val='1. entry'``
	print ("res='%s' needle='%s' key='%s', val='%s'\n", res.to_string (), needle, key, val);

	return 0;
}
