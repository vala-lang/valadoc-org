public static int main (string[] args) {
	// Create a variant:
	Variant variant = new Variant.strv ({
			"str-1",
			"str-2",
			"str-3"
		});

	// Serialize it:
	// Outut: ``["str-1","str-2","str-3"]``
	string data = Json.gvariant_serialize_data (variant, null);
	print (data);
	print ("\n");
	return 0;
}
