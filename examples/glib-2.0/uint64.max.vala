public static int main (string[] args) {
	// Output: ``max (100, 900) = 900``
	uint64 max = uint64.max (100, 900);
	print ("max (100, 900) = %" + int64.FORMAT + "\n", max);
	return 0;
}
