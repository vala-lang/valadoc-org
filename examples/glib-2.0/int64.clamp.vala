public static int main (string[] args) {
	// Output: ``10``
	int64 i = ((int64) 5).clamp (10, 15);
	print ("%" + int64.FORMAT + "\n", i);

	// Output: ``10``
	i = ((int64) 15).clamp (5, 10);
	print ("%" + int64.FORMAT + "\n", i);

	// Output: ``20``
	i = ((int64) 20).clamp (15, 25);
	print ("%" + int64.FORMAT + "\n", i);

	return 0;
}
