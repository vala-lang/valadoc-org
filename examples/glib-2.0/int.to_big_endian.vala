public static int main (string[] args) {
	if (12345.to_big_endian () == 12345) {
		stdout.puts ("big endian machine\n");
	} else {
		stdout.puts ("little endian machine\n");
	}
	return 0;
}
