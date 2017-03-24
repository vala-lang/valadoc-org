public static int main (string[] args) {
	// Output:
	//  ``llround (1.3) =  1``
	//  ``llround (1.4) =  1``
	//  ``llround (1.5) =  2``
	//  ``llround (1.6) =  2``

	print ("llround (%.1lf) =  %" + int64.FORMAT + "\n", 1.3, Math.llround (1.3));
	print ("llround (%.1lf) =  %" + int64.FORMAT + "\n", 1.4, Math.llround (1.4));
	print ("llround (%.1lf) =  %" + int64.FORMAT + "\n", 1.5, Math.llround (1.5));
	print ("llround (%.1lf) =  %" + int64.FORMAT + "\n", 1.6, Math.llround (1.6));

	return 0;
}
