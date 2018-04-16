public static int main (string[] args) {
	string str1 = "ABCDEFG";
	unowned string str2 = str1._delimit ("ADEG", 'x');

	// Output:
	//  ``xBCxxFx``
	//  ``xBCxxFx``
	print ("%s\n", str1);
	print ("%s\n", str2);
	return 0;
}
