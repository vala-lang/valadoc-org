public static int main (string[] args) {
	if (12345.to_little_endian () == 12345) {
		stdout.puts ("little endian machine\n");
	} else {
		stdout.puts ("big endian machine\n");
	}
	return 0;
}
