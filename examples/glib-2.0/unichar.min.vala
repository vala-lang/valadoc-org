public static int main (string[] args) {
	// Output: ``min ('a', 'x') = a``
	unichar min = unichar.min ('a', 'x');
	stdout.printf ("min ('a', 'x') = %s\n", min.to_string ());
	return 0;
}
