public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Out: ´´Last: "e. entry"´´
	unowned SList<string> last = list.last ();
	print ("Last: \"%s\"\n", last.data);

	return 0;
}
