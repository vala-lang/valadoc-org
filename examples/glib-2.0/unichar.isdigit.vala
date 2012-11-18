public static int main (string[] args) {
	unichar[] chars = {'a', 'Ω', '0', '9',
					   '一', '二', '零','九'}; 

	// Output: ``false false true true false false false false``
	foreach (unichar c in chars) {
		stdout.printf ("%s ", c.isdigit ().to_string ());
	}
	stdout.putc ('\n');
	return 0;
}
