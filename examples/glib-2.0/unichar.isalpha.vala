public static int main (string[] args) {
	unichar[] chars = {'a', 'Ω', '0', '9',
					   '一', '二'}; // ichi, 1; ni, 2

	// Output: ``true true false false true true``
	foreach (unichar c in chars) {
		print ("%s ", c.isalpha ().to_string ());
	}
	print ("\n");
	return 0;
}
