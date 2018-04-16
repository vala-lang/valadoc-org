public static int main (string[] args) {
	// Output: ``10``
	ushort s = ((ushort) 5).clamp (10, 15);
	print ("%hu\n", s);

	// Output: ``10``
	s = ((ushort) 15).clamp (5, 10);
	print ("%hu\n", s);

	// Output: ``20``
	s = ((ushort) 20).clamp (15, 25);
	print ("%hu\n", s);

	return 0;
}
