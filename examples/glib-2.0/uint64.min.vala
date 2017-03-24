public static int main (string[] args) {
	// Output: ``min ('100, 900) = 100``
	uint64 min = uint64.min (100, 900);
	print ("min (100, 900) = %" + uint64.FORMAT + "\n", min);
	return 0;
}
