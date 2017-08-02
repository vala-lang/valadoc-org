public int main (string[] args) {
	string str = null;
	do {
		str = stdin.read_line ();
		print ("Out: \"%s\"\n", str);
	} while (str._strip () != "exit");

	return 0;
}
