public static int main (string[] args) {
	// Output:
	//  ``10``
	//  ``99``
	//  ``1``
	//  ``9``
	stdout.printf ("%d\n", 10.abs ());
	stdout.printf ("%d\n", 99.abs ());
	stdout.printf ("%d\n", (-1).abs ());
	stdout.printf ("%d\n", (-9).abs ());

	return 0;
}
