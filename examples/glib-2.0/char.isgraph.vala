public static int main (string[] args) {
	// Output: ````
	for (int i = 0; i <= 255; i++) {
		char c = ((char) i);
		assert (c.isgraph () == (c.isprint () && c != ' '));
	}

	// Output: ``hello,world!``
	string str = "\thello,\nworld !";
	for (int i = 0; str[i] != '\0'; i++) {
		if (str[i].isgraph ()) {
			print (@"$(str[i])");
		}
	}
	print ("\n");
	return 0;
}
