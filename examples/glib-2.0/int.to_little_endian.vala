public static int main (string[] args) {
	if (12345.to_little_endian () == 12345) {
		print ("Little endian machine\n");
	} else {
		print ("Big endian machine\n");
	}
	return 0;
}
