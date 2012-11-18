public static int main (string[] args) {
	string encoded = Base64.encode ("hello, world!".data);
	stdout.printf ("Expected: aGVsbG8sIHdvcmxkIQ==\n");
	stdout.printf ("Got:      %s\n", encoded);
	return 0;
}
