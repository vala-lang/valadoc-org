public static int main (string[] args) {
	string names_str = "Ernst,Mach;Erwin,Schrödinger";

	// Output:
	//  ``'Ernst'``
	//  ``'Mach'``
	//  ``'Erwin'``
	//  ``'Schrödinger'``
	string[] names = names_str.split_set (",;");
	foreach (unowned string str in names) {
		print ("'%s'\n", str);
	}

	// Output:
	//  ``'Ernst'``
	//  ``'Mach;Erwin,Schrödinger'``
	names = names_str.split_set (",;", 2);
	foreach (unowned string str in names) {
		print ("'%s'\n", str);
	}

	return 0;
}
