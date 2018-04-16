public static int main (string[] args) {
	string decoded = (string) Base64.decode ("aGVsbG8sIHdvcmxkIQ==");
	print ("Expected: hello, world!\n");
	print ("Got:      %s\n", decoded);
	return 0;
}
