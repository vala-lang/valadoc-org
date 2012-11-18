public static int main (string[] args) {
	string decoded = (string) Base64.decode ("aGVsbG8sIHdvcmxkIQ==");
	stdout.printf ("Expected: hello, world!\n");
	stdout.printf ("Got:      %s\n", decoded);
	return 0;
}
