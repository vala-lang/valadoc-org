public static int main (string[] args) {
	string encoded = Base64.encode ("hello, world!".data);
	print ("Expected: aGVsbG8sIHdvcmxkIQ==\n");
	print ("Got:      %s\n", encoded);
	return 0;
}
