public static int main (string[] args) {
	// Output: ``max ('a', 'x') = x``
	unichar max = unichar.max ('a', 'x');
	stdout.printf ("max ('a', 'x') = %s\n", max.to_string ());
	return 0;
}
