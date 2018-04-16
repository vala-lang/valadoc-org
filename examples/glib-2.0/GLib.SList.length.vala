public static int main (string[] args) {
	SList<string> list = new SList<string> ();
	list.append ("1. entry");
	list.append ("2. entry");
	list.append ("3. entry");

	// Out: ´´length: 3´´
	uint length = list.length ();
	print ("length: %u\n", length);

	return 0;
}
