public static int main (string[] args) {
	string  wisdom = "口は禍の元。";
	unichar c = 0;
	int index = 0;

	// Output:
	//  ``0: 3:		口``
	// ``1: 6:	は``
	//  ``2: 9:		禍``
	// ``3: 12:	の``
	//  ``4: 15:	元``
	//  ``5: 18:	。``

	for (int cnt = 0; wisdom.get_next_char (ref index, out c); cnt++) {
		print ("%d: %d:\t%s\n", cnt, index, c.to_string ());
	}

	return 0;
}
