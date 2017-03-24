public static int main (string[] args) {
	if (12345.to_big_endian () == 12345) {
		print ("Big endian machine\n");
	} else {
		print ("Little endian machine\n");
	}
	return 0;
}
