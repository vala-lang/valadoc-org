public static int main (string[] args) {
	// Output: ``max ('a', 'x') = x``
	uchar min = uchar.max ('a', 'x');
	stdout.printf ("max ('a', 'x') = %c\n", min);
	return 0;
}
