public static int main (string[] args) {
	// Output: ``10``
	short s = ((short) 5).clamp (10, 15);
	print ("%hi\n", s);

	// Output: ``10``
	s = ((short) 15).clamp (5, 10);
	print ("%hi\n", s);

	// Output: ``20``
	s = ((short) 20).clamp (15, 25);
	print ("%hi\n", s);

	return 0;
}
