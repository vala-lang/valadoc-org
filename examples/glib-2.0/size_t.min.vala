public static int main (string[] args) {
	// Output: ``min ('100, 900) = 100``
	size_t min = size_t.min (100, 900);
	print ("min (100, 900) = %lu\n", min);
	return 0;
}
