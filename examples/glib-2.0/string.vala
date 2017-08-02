public static int main (string[] args) {
	string str1 = "U = R * I";
	string str2 = "R = U / I";
	string str3 = @"$str1; $str2";

	// Concat:
	// Output: ``U = R * I; R = U / I``
	print (str3 + "\n");


	// Copy:
	// Output: ``0x82e4588 != 0x82e45a8true``
	string str4 = str3;
	print ("%p != %p\n", str3, str4);


	// Compare:
	// Output: ``true``
	if (str4 == str3) {
	   print ("true\n");
	} else {
		print ("false\n");
	}


	// Verbatim strings:
	// Output:
	//  ``\tfoo``
	//  ``bar``
	//  ``\t``
	string str5 = """\tfoo
bar
\t
""";
	print (str5);
	return 0;
}
