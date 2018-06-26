public static int main (string[] args) {
	string str = "everybody loves the gimp!!!!!!";
	char* ptr = str;

	// Output: ``everybody loves thes the gimp!``
	Memory.move (ptr + 18, ptr + 13, 12);
	print ("%s\n", str);
	return 0;
}
