public static int main (string[] args) {
	char[] data = {'h', 'e', 'l', 'l', 'o', ',', ' ', 'w', 'o', 'r', 'l', 'd', '!', '\0'};

	// Copy the data into a typeless buffer:
	// Do not copy arrays / classes / etc when you do not know what you are doing.
	// You may break your ref counters / lose array length information / etc
	void* copy = Memory.dup (data, (uint) (sizeof (char)*data.length));
	print ("%s\n", (string) copy);
	free (copy);

	return 0;
}
