public static int main (string[] args) {
	// Output: ``min ('100, 900) = 100``
	int64 min = int64.min (100, 900);
	print ("min (100, 900) = %" + int64.FORMAT + "\n", min);
	return 0;
}
