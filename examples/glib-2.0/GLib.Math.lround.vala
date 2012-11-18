public static int main (string[] args) {
	// Output:
	//  ``lround (1.3) =  1``
	//  ``lround (1.4) =  1``
	//  ``lround (1.5) =  2``
	//  ``lround (1.6) =  2``

	stdout.printf ("lround (%.1lf) =  %li\n", 1.3, Math.lround (1.3));
	stdout.printf ("lround (%.1lf) =  %li\n", 1.4, Math.lround (1.4));
	stdout.printf ("lround (%.1lf) =  %li\n", 1.5, Math.lround (1.5));
	stdout.printf ("lround (%.1lf) =  %li\n", 1.6, Math.lround (1.6));

	return 0;
}
