public static int main (string[] args) {
	string str1 = "ABCDEFG";
	string str2 = str1.delimit ("ADEG", 'x');

	// Output:
	//  ``ABCDEFG``
	//  ``xBCxxFx``
	stdout.printf ("%s\n", str1);
	stdout.printf ("%s\n", str2);
	return 0;
}
