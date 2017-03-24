public static int main (string[] args) {
	unichar[] chars = {'a', 'z', 'A', 'Z', '0', '9',
					   'α', 'Ω',
					   '一', '二', // ichi, 1; ni, 2
					   '!', ',', '\n'}; 

	// Output: ``true true true true true true true true true true false false false``
	foreach (unichar c in chars) {
		print ("%s ", c.isalnum ().to_string ());
	}
	print ("\n");
	return 0;
}
