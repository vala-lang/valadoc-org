public static int main (string[] args) {
	PtrArray array = new PtrArray ();
	array.add ("first entry");
	array.add ("second entry");
	array.add ("third entry");

	// Output: ``3``
	print ("%u\n", array.len);
	return 0;
}
