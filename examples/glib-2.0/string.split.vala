public static int main (string[] args) {
	string doctors_str = "William Hartnell, Patrick Troughton, Jon Pertwee, Tom Baker, Peter Davison, Colin Baker, Sylvester McCoy";

	// Output:
	//  ``'William Hartnell'``
	//  ``'Patrick Troughton'``
	//  ``'Jon Pertwee'``
	//  ``'Tom Baker'``
	//  ``'Peter Davison'``
	//  ``'Colin Baker'``
	//  ``'Sylvester McCoy'``
	string[] doctors = doctors_str.split (", ");
	foreach (unowned string str in doctors) {
		print ("'%s'\n", str);
	}

	// Output:
	//  ``'Alistair'``
	//  ``'Gordon Lethbridge-Stewart'``
	string line = "Alistair Gordon Lethbridge-Stewart";
	string[] lines = line.split (" ", 2);
	foreach (unowned string str in lines) {
		print ("'%s'\n", str);
	}

	return 0;
}
