public static int main (string[] args) {
	Variant var1 = new Variant ("(ssi)", "aa", "bb", 10);
	string? val1 = null;
	string? val2 = null;
	int val3 = -1;

	VariantIter iter = var1.iterator ();
	iter.next ("s", &val1);
	iter.next ("s", &val2);
	iter.next ("i", &val3);

	// Output: ``aa, bb, 10``
	print ("%s, %s, %d\n", val1, val2, val3);

	return 0;
}
