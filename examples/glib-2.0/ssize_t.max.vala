public static int main (string[] args) {
	// Output: ``max (100, 900) = 900``
	ssize_t max = ssize_t.max (100, 900);
	print ("max (100, 900) = %lu\n", max);
	return 0;
}
