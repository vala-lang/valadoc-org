public static int main (string[] args) {
	GenericArray<int> array = new GenericArray<int> ();
	array.add (1);
	array.add (2);
	array.add (3);
	array.add (4);

	// This wont work for strings!
	array.remove (3);

	// Output:
	//  ``1``
	//  ``2``
	//  ``4``
	array.foreach ((val) => {
		print ("%d\n", val);
	});

	return 0;
}
