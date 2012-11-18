public static int main (string[] args) {
	// Output: ``min ('a', 'x') = a``
	uchar min = uchar.min ('a', 'x');
	stdout.printf ("min ('a', 'x') = %c\n", min);
	return 0;
}
