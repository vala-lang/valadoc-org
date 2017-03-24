public static int main (string[] args) {
	// Create a variant:
	Variant variant = new Variant.strv ({
			"str-1",
			"str-2",
			"str-3"
		});

	// Serialize it:
	Json.Node root = Json.gvariant_serialize (variant);


	// To string: (see gobject_to_data)
	Json.Generator generator = new Json.Generator ();
	generator.set_root (root);
	string data = generator.to_data (null);

	// Output:
	// ``["str-1","str-2","str-3"]``
	print (data);
	print ("\n");

	return 0;
}
